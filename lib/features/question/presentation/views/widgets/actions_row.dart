import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:word_game/features/home/presentation/views/widgets/email_view_body.dart';
import 'package:word_game/features/question/presentation/views/widgets/rewardedAd.dart';

import '../../../../../core/core_widget/navigate.dart';
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
              goTo(EmailView());
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
        //const Expanded(child:  RewardedAdd()),
        const Expanded(child: SizedBox()),
        TextButton(
            onPressed: () {
              goTo(Coins());
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
