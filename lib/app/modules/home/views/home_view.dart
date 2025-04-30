import 'package:alquran/app/constants/color.dart';
import 'package:alquran/app/data/models/detail_surah.dart' as detail;
import 'package:alquran/app/data/models/surah.dart';
import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quran App',
          style: TextStyle(fontSize: 25, color: appWhite),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.SEARCH),
            icon: Icon(Icons.search),
            color: Colors.white,
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assalamualaikum',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              GetBuilder<HomeController>(
                builder: (c) {
                return FutureBuilder<Map<String, dynamic>?>(
                future: c.getLastRead(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      width: Get.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [appPurpleLight, appPurpleDark],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: -35,
                            right: -25,
                            child: Opacity(
                              opacity: 0.7,
                              child: Container(
                                width: 200,
                                height: 200,
                                child: Image.asset(
                                  'assets/images/alquran.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.menu_book_rounded,
                                      color: appWhite,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Terakhir dibaca',
                                      style: TextStyle(color: appWhite),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Text(
                                  'Loading....',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: appWhite,
                                  ),
                                ),
                                Text('', style: TextStyle(color: appWhite)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (snapshot.data == null) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      width: Get.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [appPurpleLight, appPurpleDark],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: -35,
                            right: -25,
                            child: Opacity(
                              opacity: 0.7,
                              child: Container(
                                width: 200,
                                height: 200,
                                child: Image.asset(
                                  'assets/images/alquran.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.menu_book_rounded,
                                      color: appWhite,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Terakhir dibaca',
                                      style: TextStyle(color: appWhite),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Text(
                                  'Belum Ada Data!',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: appWhite,
                                  ),
                                ),
                                Text('', style: TextStyle(color: appWhite)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  Map<String, dynamic>? lastRead = snapshot.data;
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: Get.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [appPurpleLight, appPurpleDark],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        onLongPress: () {
                          if (lastRead != null) {
                            Get.defaultDialog(
                              title: "Delete",
                              middleText: "Are You Sure?",
                              actions: [
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor:
                                        Get.isDarkMode ? appWhite : appPurple,
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color:
                                          Get.isDarkMode ? appPurple : appWhite,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Get.isDarkMode ? appWhite : appPurple,
                                  ),
                                  onPressed: () {
                                    c.deleteLastRead(lastRead['id']);
                                    Get.back();
                                  },
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                      color:
                                          Get.isDarkMode ? appPurple : appWhite,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                        onTap: () {
                          if (lastRead != null) {
                            switch (lastRead["via"]) {
                                      case "juz":
                                   Map<String, dynamic> dataMapingPerJuz =
                                controller.allJuz[lastRead['juz']-1];
                                        Get.toNamed(
                                  Routes.DETAIL_JUZ,
                                  arguments: {"juz": dataMapingPerJuz, "bookmark" : lastRead},
                                );
                                        break;
                                      default:
                                    Get.toNamed(
                                    Routes.DETAIL_SURAH,
                                    arguments: {
                                      "name" : lastRead["surah"].toString().replaceAll("+", "'"),
                                      "number" : lastRead["number_surah"],
                                      "bookmark" : lastRead
                                    },
                                  );
                                      break;
                                    }
                          }
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: -35,
                                right: -25,
                                child: Opacity(
                                  opacity: 0.7,
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    child: Image.asset(
                                      'assets/images/alquran.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.menu_book_rounded,
                                          color: appWhite,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          'Terakhir dibaca',
                                          style: TextStyle(color: appWhite),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 30),
                                    Text(
                                      '${lastRead!['surah'].toString().replaceAll("+", "'")}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: appWhite,
                                      ),
                                    ),
                                    Text(
                                      'Juz ${lastRead['juz']} | Ayat ${lastRead['ayat']}',
                                      style: TextStyle(color: appWhite),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
              },),
              TabBar(
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: 'Surah'),
                  Tab(text: 'Juz'),
                  Tab(text: 'Bookmark'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    FutureBuilder<List<Surah>>(
                      future: controller.getAllSurah(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text(
                              'Tidak Ada Data!',
                              style: TextStyle(
                                color: Get.isDarkMode ? appWhite : appPurple,
                              ),
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Surah surah = snapshot.data![index];
                            return ListTile(
                              onTap:
                                  () => Get.toNamed(
                                    Routes.DETAIL_SURAH,
                                    arguments: {
                                      "name" : surah.name.transliteration.id,
                                      "number" : surah.number
                                    },
                                  ),
                              leading: Container(
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
                                    '${surah.number}',
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
                              title: Text(
                                '${surah.name.transliteration.id}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              subtitle: Text(
                                '${surah.numberOfVerses} Ayat | ${surah.revelation.id}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              trailing: Text(
                                '${surah.revelation.arab}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            );
                          },
                        );
                      },
                    ),
                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: controller.getAllJuz(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          controller.dataAlljuz.value = false;
                          return Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text(
                              'Tidak Ada Data!',
                              style: TextStyle(
                                color: Get.isDarkMode ? appWhite : appPurple,
                              ),
                            ),
                          );
                        }
                        controller.dataAlljuz.value = true;
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> dataMapingPerJuz =
                                snapshot.data![index];
                            return ListTile(
                              onTap: () {
                                Get.toNamed(
                                  Routes.DETAIL_JUZ,
                                  arguments: {"juz" : dataMapingPerJuz},
                                );
                              },
                              subtitle: Text(
                                '${(dataMapingPerJuz["start"]["surah"] as detail.DetailSurah).name.transliteration.id} ${(dataMapingPerJuz["start"]["ayat"] as detail.Verse).number.inSurah} - ${(dataMapingPerJuz["end"]["surah"] as detail.DetailSurah).name.transliteration.id} ${(dataMapingPerJuz["end"]["ayat"] as detail.Verse).number.inSurah}',
                              ),
                              title: Text(
                                ' Juz ${index + 1}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              leading: Container(
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
                                    '${index + 1}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color:
                                          Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? appPurple
                                              : appPurple,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    GetBuilder<HomeController>(
                      builder: (c) {
                        if (c.dataAlljuz.isFalse) {
                          return Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 10),
                                Text(
                                  'Sedang Menunggu Data Juz....',
                                  style: TextStyle(
                                    color: Get.isDarkMode ? appWhite : appPurple,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                        return FutureBuilder<List<Map<String, dynamic>>>(
                          
                          future: c.getBookmark(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.data!.length == 0) {
                              return Center(
                                child: Text(
                                  "Belum Ada Bookmark",
                                  style: TextStyle(
                                    color:
                                        Get.isDarkMode ? appWhite : appPurple,
                                  ),
                                ),
                              );
                            }
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> data =
                                    snapshot.data![index];
                                return ListTile(
                                  onTap: () {
                                    switch (data["via"]) {
                                      case "juz":
                                   Map<String, dynamic> dataMapingPerJuz =
                                controller.allJuz[data['juz']-1];
                                        Get.toNamed(
                                  Routes.DETAIL_JUZ,
                                  arguments: {"juz": dataMapingPerJuz, "bookmark" : data},
                                );
                                        break;
                                      default:
                                    Get.toNamed(
                                    Routes.DETAIL_SURAH,
                                    arguments: {
                                      "name" : data["surah"].toString().replaceAll("+", "'"),
                                      "number" : data["number_surah"],
                                      "bookmark" : data
                                    },
                                  );
                                      break;
                                    }
                                  },
                                  leading: Container(
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
                                        '${index + 1}',
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
                                  title: Text(
                                    "${data['surah'].toString().replaceAll("+", "'")}",
                                    style: TextStyle(
                                      color:
                                          Get.isDarkMode ? appWhite : appPurple,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "Ayat ${data['ayat']} via ${data['via']}",
                                    style: TextStyle(
                                      color:
                                          Get.isDarkMode ? appWhite : appPurple,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      c.deleteBookmark(data['id']);
                                    },
                                    color:
                                        Get.isDarkMode ? appWhite : appPurple,
                                    icon: Icon(Icons.delete),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.changeTheme(),
        backgroundColor:
            Theme.of(context).brightness == Brightness.light
                ? appPurple
                : appWhite,
        foregroundColor:
            Theme.of(context).brightness == Brightness.light
                ? appPurple
                : appWhite,
        child: Icon(
          Icons.color_lens,
          color:
              Theme.of(context).brightness == Brightness.light
                  ? appWhite
                  : appPurple,
        ),
      ),
    );
  }
}
