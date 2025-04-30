import 'package:alquran/app/constants/color.dart';
import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  const IntroductionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Al-Quran Apps',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 5),
            Text(
              'By Triyasa Bintang Ardana',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 30),
            Container(
              width: 250,
              height: 250,
              child: Lottie.asset('assets/lottie/animasi_introduction2.json'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).brightness == Brightness.dark
                        ? appWhite
                        : appPurple,
                backgroundColor:
                    Theme.of(context).brightness == Brightness.dark
                        ? appWhite
                        : appPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              onPressed: () => Get.offAllNamed(Routes.HOME),
              child: Text(
                'GET STARTED',
                style: TextStyle(
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? appPurple
                          : appWhite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
