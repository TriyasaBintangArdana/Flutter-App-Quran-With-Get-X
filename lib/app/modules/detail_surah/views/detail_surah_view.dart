import 'package:alquran/app/constants/color.dart';
import 'package:alquran/app/data/models/detail_surah.dart' as detail;
import 'package:alquran/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'package:get/get.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  final homeC = Get.find<HomeController>();
  Map<String, dynamic>? bookmark;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SURAH ${Get.arguments['name']}',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<detail.DetailSurah>(
        future: controller.getDetailSurah(Get.arguments['number'].toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Center(child: Text('Tidak Ada Data!'));
          }
          if (Get.arguments["bookmark"] != null) {
            bookmark = Get.arguments["bookmark"];
           controller.autoScroll.scrollToIndex(
                bookmark!["index_ayat"] + 2,
                duration: Duration(seconds: 2),
                preferPosition: AutoScrollPosition.begin,
              );
          }
          print(bookmark);
          detail.DetailSurah surah = snapshot.data!;

          List<Widget>
          allAyat = List.generate(snapshot.data?.verses.length ?? 0, (index) {
            detail.Verse? ayat = snapshot.data!.verses[index];
            return AutoScrollTag(
              key: ValueKey(index + 2),
              index: index + 2,
              controller: controller.autoScroll,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Card(
                    color: Get.isDarkMode ? Colors.grey[700] : Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
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
                                '${ayat.number!.inSurah}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Get.isDarkMode ? appPurple : appPurple,
                                ),
                              ),
                            ),
                          ),
                          GetBuilder<DetailSurahController>(
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
                                                  snapshot.data!,
                                                  ayat,
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
                                                  snapshot.data!,
                                                  ayat,
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
                                    (ayat.kondisiAudio == "stop")
                                        ? IconButton(
                                          onPressed: () => c.playAudio(ayat),
                                          icon: Icon(Icons.play_arrow),
                                        )
                                        : Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            (ayat.kondisiAudio == "playing")
                                                ? IconButton(
                                                  onPressed: () {
                                                    c.pauseAudio(ayat);
                                                  },
                                                  icon: Icon(Icons.pause),
                                                )
                                                : IconButton(
                                                  onPressed: () {
                                                    c.resumeAudio(ayat);
                                                  },
                                                  icon: Icon(Icons.play_arrow),
                                                ),
                                            IconButton(
                                              onPressed: () {
                                                c.stopAudio(ayat);
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
                  Text(
                    '${ayat.text!.arab}',
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${ayat.text!.transliteration!.en}',
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    '${ayat.translation!.id}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            );
          });

          return ListView(
            controller: controller.autoScroll,
            padding: EdgeInsets.all(20),
            children: [
              AutoScrollTag(
                key: ValueKey(0),
                index: 0,
                controller: controller.autoScroll,
                child: GestureDetector(
                  onTap:
                      () => Get.defaultDialog(
                        title: "TAFSIR",
                        titleStyle: TextStyle(fontWeight: FontWeight.bold),
                        content: Container(
                          child: Text(
                            surah.tafsir.id,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                  child: Container(
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
                            '${surah.name.transliteration.id.toUpperCase()}',
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
                            style: TextStyle(fontSize: 14, color: appWhite),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AutoScrollTag(
                key: ValueKey(1),
                index: 1,
                controller: controller.autoScroll,
                child: const SizedBox(height: 30),
              ),
              ...allAyat,
              // ListView.builder(
              //   shrinkWrap: true,
              //   physics: NeverScrollableScrollPhysics(),
              //   itemCount: snapshot.data!.verses!.length ?? 0,
              //   itemBuilder: (context, index) {
              //     if (snapshot!.data!.verses!.length == 0) {
              //       return SizedBox();
              //     }

              //   },
              // ),
            ],
          );
        },
      ),
    );
  }
}
