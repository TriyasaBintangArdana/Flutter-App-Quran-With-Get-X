import 'dart:convert';

import 'package:alquran/app/constants/color.dart';
import 'package:alquran/app/data/db/bookmart.dart';
import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  List<Map<String,dynamic>> allJuz = [];
  RxBool isDark = false.obs;
  RxBool dataAlljuz = false.obs;
  List<Surah> allSurah = [];
  DataBaseManager database = DataBaseManager.instance;

  void deleteLastRead(int id) async {
  Database db = await database.db;
  db.delete("bookmark",where: "id = $id");
  update();
  Get.snackbar("Berhasil", "Berhasil Menghapus Bookmark!",colorText: appWhite);
 }

Future<Map<String,dynamic>?> getLastRead() async {
 Database db = await database.db;
   List<Map<String,dynamic>> dataLastRead = await db.query(
    "bookmark",
    where: "last_read = 1",);
  if (dataLastRead.length == 0) {
    return null;
  } else {
    return dataLastRead.first;
  }
}

void deleteBookmark(int id) async {
  Database db = await database.db;
  db.delete("bookmark",where: "id = $id");
  Get.snackbar("Berhasil", "Berhasil Menghapus Bookmark!",colorText: appWhite);
  update();
 }

 Future<List<Map<String,dynamic>>> getBookmark() async {
    Database db = await database.db;
   List<Map<String,dynamic>> allDataBookmark = await db.query(
    "bookmark",
    where: "last_read = 0",
    orderBy: "juz, via, surah, ayat");
   return allDataBookmark;
  }

  void changeTheme() async {
    Get.isDarkMode ? Get.changeTheme(themeLight) : Get.changeTheme(themeDark);
    isDark.toggle();
    final box = GetStorage();
    if (Get.isDarkMode) {
      // dark > light
      box.remove("themeDark");
    } else {
      //light > dark
    box.write("themeDark", true);
    }
  }


  Future<List<Surah>>getAllSurah() async {

  Uri url = Uri.parse('https://api.quran.gading.dev/surah');
  var res = await http.get(url);

  List data = (json.decode(res.body) as Map<String,dynamic>)['data'];
  if (data == null || data.isEmpty) {
    return [];
  } else{
    allSurah = data.map((e) => Surah.fromJson(e)).toList();
    return allSurah ;
  }
  }


  Future<List<Map<String, dynamic>>>getAllJuz() async {
  int juz = 1;

  List<Map<String,dynamic>> penampunganAyat = [];


  for (var i = 1; i <= 114 ; i++) {
    var res = await http.get(Uri.parse('https://api.quran.gading.dev/surah/$i'));
    Map<String,dynamic> rawData = json.decode(res.body)['data'];
    DetailSurah data = DetailSurah.fromJson(rawData);

    if (data.verses != null) {
      data.verses.forEach((ayat) {
        if (ayat.meta.juz == juz) {
          penampunganAyat.add({
            "surah" : data,
            "ayat" : ayat
          });
        } else {
          allJuz.add({
            "juz" : juz,
            "start" : penampunganAyat[0],
            "end" : penampunganAyat[penampunganAyat.length - 1 ],
            "verses" : penampunganAyat,
          });
          juz++;
          penampunganAyat = [];
        penampunganAyat.add({
            "surah" : data,
            "ayat" : ayat
          });
        }
      },);
    }
  }
  allJuz.add({
    "juz" : juz,
    "start" : penampunganAyat[0],
    "end" : penampunganAyat[penampunganAyat.length - 1],
    "verses" : penampunganAyat
  });
    return allJuz;
  }
}
