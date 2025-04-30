import 'package:alquran/app/constants/color.dart';
import 'package:alquran/app/data/models/detail_surah.dart' as detail;
import 'package:alquran/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  final Map<String, dynamic> dataMapingPerJuz = Get.arguments["juz"];
  final homeC = Get.find<HomeController>();
  Map<String, dynamic>? bookmark;
  @override
  Widget build(BuildContext context) {
     if (Get.arguments["bookmark"] != null) {
            bookmark = Get.arguments["bookmark"];
           controller.autoScroll.scrollToIndex(
                bookmark!["index_ayat"],
                duration: Duration(seconds: 2),
                preferPosition: AutoScrollPosition.begin,
              );
          }
          print(bookmark);

     List<Widget> allAyat = List.generate((dataMapingPerJuz['verses'] as List).length,(index) {
      Map<String, dynamic> ayat = dataMapingPerJuz['verses'][index];
              detail.DetailSurah surah = ayat['surah'];
              detail.Verse verse = ayat['ayat'];
              return AutoScrollTag(
                key: ValueKey(index),
                controller: controller.autoScroll,
                index: index,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (verse.number.inSurah == 1)
                      Center(
                        child: GestureDetector(
                          onTap:
                              () => Get.defaultDialog(
                                title: "TAFSIR",
                                titleStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                content: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    '${surah.tafsir.id}',
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                          child: Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: [appPurpleLight, appPurple],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    '${surah.name.transliteration.id}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: appWhite,
                                    ),
                                  ),
                                  Text(
                                    '(${surah.name.translation.id})',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: appWhite,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '${surah.numberOfVerses} Ayat | ${surah.revelation.id}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: appWhite,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    Card(
                      color:
                          Get.isDarkMode
                              ? Colors.grey[700]
                              : Colors.grey[300],
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        Get.isDarkMode
                                            ? 'assets/images/list_light.png'
                                            : 'assets/images/list_biru.png',
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${verse.number.inSurah}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color:
                                           Get.isDarkMode
                                                ? appPurple
                                                : appPurple,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  surah.name.transliteration.id,
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            GetBuilder<DetailJuzController>(
                              builder:
                                  (c) => Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Get.defaultDialog(
                                            title: "BOOKMARK",
                                            middleText: "Pilih Jenis Bookmark",
                                            actions: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Get.isDarkMode
                                                          ? appWhite
                                                          : appPurple,
                                                  foregroundColor:
                                                      Get.isDarkMode
                                                          ? appWhite
                                                          : appPurple,
                                                ),
                                                onPressed: () async {
                                                await c.addBookmark(
                                                    true,
                                                    surah,
                                                    verse,
                                                    index,
                                                  );
                                                  homeC.update();
                                                },
                                                child: Text(
                                                  'LAST READ',
                                                  style: TextStyle(
                                                    color:
                                                        Get.isDarkMode
                                                            ? appPurple
                                                            : appWhite,
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Get.isDarkMode
                                                          ? appWhite
                                                          : appPurple,
                                                ),
                                                onPressed: () {
                                                  c.addBookmark(
                                                    false,
                                                    surah,
                                                    verse,
                                                    index,
                                                  );
                                                },
                                                child: Text(
                                                  'BOOKMARK',
                                                  style: TextStyle(
                                                    color:
                                                        Get.isDarkMode
                                                            ? appPurple
                                                            : appWhite,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                        icon: Icon(Icons.bookmark_outline),
                                      ),
                                      (verse.kondisiAudio == "stop")
                                          ? IconButton(
                                            onPressed: () => c.playAudio(verse),
                                            icon: Icon(Icons.play_arrow),
                                          )
                                          : Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              (verse.kondisiAudio == "playing")
                                                  ? IconButton(
                                                    onPressed: () {
                                                      c.pauseAudio(verse);
                                                    },
                                                    icon: Icon(Icons.pause),
                                                  )
                                                  : IconButton(
                                                    onPressed: () {
                                                      c.resumeAudio(verse);
                                                    },
                                                    icon: Icon(
                                                      Icons.play_arrow,
                                                    ),
                                                  ),
                                              IconButton(
                                                onPressed: () {
                                                  c.stopAudio(verse);
                                                },
                                                icon: Icon(Icons.stop),
                                              ),
                                            ],
                                          ),
                                    ],
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${verse.text.transliteration.en}',
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${verse.text.arab}',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      '${verse.translation.id}',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              );
            
     });     
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Juz ${dataMapingPerJuz['juz']}',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(25),
        controller: controller.autoScroll,
        children: allAyat
      ),
    );
  }
}
