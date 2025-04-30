import 'dart:convert';

import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:http/http.dart' as http;

void main() async {
  int juz = 1;

  List<Map<String, dynamic>> penampunganAyat = [];
  List<Map<String, dynamic>> allJuz = [];

  for (var i = 1; i <= 114; i++) {
    var res = await http.get(
      Uri.parse('https://api.quran.gading.dev/surah/$i'),
    );
    Map<String, dynamic> rawData = json.decode(res.body)['data'];
    DetailSurah data = DetailSurah.fromJson(rawData);

    if (data.verses != null) {
      data.verses.forEach((ayat) {
        if (ayat.meta!.juz == juz) {
          penampunganAyat.add({
            "surah": data.name!.translation!.id,
            "ayat": ayat,
          });
        } else {
          print("==========");
          print("BERHASIL MEMASUKAN JUZ $juz");
          print("Start:");
          print(
            "Ayat : ${(penampunganAyat[0]['ayat'] as Verse).number!.inSurah}",
          );
          print("${(penampunganAyat[0]['ayat'] as Verse).text!.arab}");
          print("END");
          print(
            "Ayat : ${(penampunganAyat[penampunganAyat.length - 1]['ayat'] as Verse).number!.inSurah}",
          );
          print(
            "${(penampunganAyat[penampunganAyat.length - 1]['ayat'] as Verse).text!.arab}",
          );
          allJuz.add({
            "juz": juz,
            "start": penampunganAyat[0],
            "end": penampunganAyat[penampunganAyat.length - 1],
            "verses": penampunganAyat,
          });
          juz++;
          penampunganAyat = [];
          penampunganAyat.add({
            "surah": data.name!.transliteration!.id,
            "ayat": ayat,
          });
        }
      });
    }
  }
  print("==========");
  print("BERHASIL MEMASUKAN JUZ $juz");
  print("Start:");
  print("Ayat : ${(penampunganAyat[0]['ayat'] as Verse).number!.inSurah}");
  print("${(penampunganAyat[0]['ayat'] as Verse).text!.arab}");
  print("END");
  print(
    "Ayat : ${(penampunganAyat[penampunganAyat.length - 1]['ayat'] as Verse).number!.inSurah}",
  );
  print(
    "${(penampunganAyat[penampunganAyat.length - 1]['ayat'] as Verse).text!.arab}",
  );
  allJuz.add({
    "juz": juz,
    "start": penampunganAyat[0],
    "end": penampunganAyat[penampunganAyat.length - 1],
    "verses": penampunganAyat,
  });
}
