import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:word_game/core/resources_manager/delay_manager.dart';

import '../../../../../core/resources_manager/colors_manager.dart';
import '../../../../home/presentation/views/widgets/coins_view_body.dart';

class ActionsRow extends StatelessWidget {
  const ActionsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
            onPressed: () {
              //goTo(EmailView());
            },
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ColorsManager.green,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.mail,
                      color: ColorsManager.white,
                    ),
                  ),
                ),
              ],
            )),
        const Expanded(child: SizedBox()),
        TextButton(
            onPressed: () {
              Get.to(const Coins(),
                  duration: const Duration(milliseconds: 500),
                  transition: DelayManager.rightToLeft);
            },
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ColorsManager.green,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(
                      FontAwesomeIcons.coins,
                      color: ColorsManager.white,
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
