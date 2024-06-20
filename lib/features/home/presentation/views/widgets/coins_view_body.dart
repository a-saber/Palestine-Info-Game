import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_game/core/core_widget/default_appbar.dart';
import 'package:word_game/core/core_widget/default_button.dart';
import 'package:word_game/core/resources_manager/delay_manager.dart';
import 'package:word_game/features/home/presentation/views/get_points_view.dart';

class Coins extends StatelessWidget {
  const Coins({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        text: 'كسب النقاط',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultButton(
              onPressed: () {
                Get.to(const GetPointsView(title: 'استغفر الله'),
                    duration: const Duration(milliseconds: 500),
                    transition: DelayManager.rightToLeft);
              },
              text: 'استغفر الله 10 مرات \n و أحصل على 5 نقاط',
            ),
            DefaultButton(
                onPressed: () {
                  Get.to(const GetPointsView(title: 'كبر'),
                      duration: const Duration(milliseconds: 500),
                      transition: DelayManager.rightToLeft);
                },
                text: 'كبر 10 مرات \nو أحصل على 5 نقاط'),
            DefaultButton(
              onPressed: () {
                Get.to(const GetPointsView(title: 'هلل'),
                    duration: const Duration(milliseconds: 500),
                    transition: DelayManager.rightToLeft);
              },
              text: 'هلل 10 مرات \nو أحصل على 5 نقاط',
            ),
            DefaultButton(
              onPressed: () {
                Get.to(const GetPointsView(title: 'سبح الله'),
                    duration: const Duration(milliseconds: 500),
                    transition: DelayManager.rightToLeft);
              },
              text: 'سبح الله 10 مرات \nو أحصل على 5 نقاط',
            ),
          ],
        ),
      ),
    );
  }
}
