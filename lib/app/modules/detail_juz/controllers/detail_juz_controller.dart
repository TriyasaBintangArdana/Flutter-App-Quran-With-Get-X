import 'package:alquran/app/constants/color.dart';
import 'package:alquran/app/data/db/bookmart.dart';
import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sqflite/sqflite.dart';

class DetailJuzController extends GetxController {
  int index = 0;
  final player = AudioPlayer();
  AutoScrollController autoScroll = AutoScrollController();
  Verse? lastVerse;
   DataBaseManager database = DataBaseManager.instance;

 Future<void> addBookmark(bool lastRead, DetailSurah surah, Verse ayat, int indexAyat) async {
    Database db = await database.db;
    bool flagExist = false;
  if (lastRead == true) {
    await db.delete("bookmark",where: "last_read = 1");
  } else {
    List checkData = await db.query("bookmark",
     columns: ["surah", "number_surah", "ayat", "juz", "via", "index_ayat", "last_read"],
     where: "surah = '${surah.name.transliteration.id.replaceAll("'", "+")}' and number_surah = ${surah.number} and ayat = ${ayat.number.inSurah} and juz = ${ayat.meta.juz} and via = 'juz' and index_ayat = $indexAyat and last_read = 0");
    if (checkData.length != 0) {
      flagExist = true;
    }
  }
  if (flagExist == false) {
   await db.insert(
    "bookmark", 
    {
      "surah" : "${surah.name.transliteration.id.replaceAll("'", "+")}",
      "number_surah" : surah.number,
      "ayat" : ayat.number.inSurah,
      "juz" : ayat.meta.juz,
      "via" : "juz",
      "index_ayat" : indexAyat,
      "last_read" : lastRead == true ? 1 : 0,
    });
    Get.back();
    Get.snackbar("Berhasil", "Berhasil Menambahkan Bookmark",
    backgroundColor: appPurpleYoung,colorText: appPurple);
    } else {
    Get.back();
    Get.snackbar("Gagal", "Bookmark Telah Tersedia",
    backgroundColor: appPurpleYoung,colorText: appPurple);
    }

    var data = await db.query("bookmark");
    print(data);
  }
  void stopAudio(Verse? ayat) async{
      try {
        await player.stop();
        ayat!.kondisiAudio = "stop";
        update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: e.code.toString()
        );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: e.message.toString()
        );
    } catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Tidak dapat stop audio"
        );
    }
    }
    void resumeAudio(Verse? ayat) async{
      try {
        ayat!.kondisiAudio = "playing";
        update();
        await player.play();
        ayat!.kondisiAudio = "stop";
        update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: e.code.toString()
        );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: e.message.toString()
        );
    } catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Tidak dapat resume audio"
        );
    }
    }
      void pauseAudio(Verse? ayat) async{
      try {
        await player.pause();
       ayat!.kondisiAudio = "pause";
       update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: e.code.toString()
        );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: e.message.toString()
        );
    } catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Tidak dapat pause audio"
        );
    }
    }
      void playAudio(Verse? ayat) async{
      if (ayat?.audio.primary != null) {
    try {
      if (lastVerse == null) {
        lastVerse = ayat;
      }
      lastVerse!.kondisiAudio = "stop";
      lastVerse = ayat;
      lastVerse!.kondisiAudio = "stop";
      update();
      await player.stop();
      await player.setUrl(ayat!.audio.primary);
      ayat.kondisiAudio = "playing";
      update();
      await player.play();
      ayat.kondisiAudio = "stop";
      await player.stop();
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: e.code.toString()
        );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: e.message.toString()
        );
    } catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: e.toString()
        );
    }
      } else {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Tidak data memutar audio / audio tidak ada"
        );
      }
    }
  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
