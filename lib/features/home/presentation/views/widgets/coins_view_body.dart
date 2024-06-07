import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:word_game/core/core_widget/default_appbar.dart';
import 'package:word_game/core/core_widget/default_button.dart';
import 'package:word_game/core/resources_manager/colors_manager.dart';
import '../../../../question/presentation/views/widgets/rewardedAd.dart';

class Coins extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            DefaultAppBar(
              text: 'كسب النقاط',
              icon: FontAwesomeIcons.coins,
              sizeIcon: 25.0,
              fontSize: 22.0,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  DefaultButton(
                    function: () {},
                    text: 'شارك اللعبة العازي مع أصدقائك و أحصل على 5 نقطة',
                    icon: FontAwesomeIcons.shareNodes,
                    sizefont: 15.0,
                    paddingLeft: 10.0,
                    paddingRight: 5.0,
                    sizeIcon: 20.0,
                    width: 500,
                    height: 75,
                    radius: 10.0,
                  ),
                  DefaultButton(
                    function: () {},
                    text: 'تابعنا على أنستغرام و أحصل على 5 نقاط',
                    icon: FontAwesomeIcons.instagram,
                    sizefont: 15.0,
                    paddingLeft: 10.0,
                    paddingRight: 20.0,
                    sizeIcon: 20.0,
                    width: 495,
                    height: 75,
                    radius: 10.0,
                  ),
                  DefaultButton(
                    function: () {},
                    text: 'ضع لايك لصفحتنا على الفيسبوك و أحصل على 5 نقاط',
                    icon: FontAwesomeIcons.facebook,
                    sizefont: 15.0,
                    paddingLeft: 10.0,
                    paddingRight: 5.0,
                    sizeIcon: 20.0,
                    width: 495,
                    height: 75,
                    radius: 10.0,
                  ),
                  DefaultButton(
                    function: () {},
                    text: 'تابعنا على تويتر و أحصل على 5 نقاط',
                    icon: FontAwesomeIcons.twitter,
                    sizefont: 16.0,
                    paddingLeft: 10.0,
                    paddingRight: 20.0,
                    sizeIcon: 20.0,
                    width: 495,
                    height: 75,
                    radius: 10.0,
                  ),
                  //const RewardedAdd(fromGainPoints: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
