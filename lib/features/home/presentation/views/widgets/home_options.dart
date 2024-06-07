import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:word_game/core/core_widget/alerts/alert_restart.dart';

import 'package:word_game/core/manager/app_cubit.dart';
import 'package:word_game/core/manager/app_states.dart';
import 'package:word_game/features/groups/presentation/views/group_view.dart';

import '../../../../../core/core_widget/default_button.dart';
import '../../../../../core/core_widget/navigate.dart';
import 'coins_view_body.dart';

class HomeOptions extends StatelessWidget {
  const HomeOptions({super.key, required this.slidingAnimation});
  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is ShowRestartState) {
        showDialog(
            context: context,
            builder: (BuildContext ctx) => alertRestart(context),
            barrierDismissible: false);
      }
    }, builder: (context, state) {
      var height = MediaQuery.of(context).size.height;
      return AnimatedBuilder(
        animation: slidingAnimation,
        builder: (BuildContext context, _) {
          return SlideTransition(
            position: slidingAnimation,
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.1,
                  child: DefaultButton(
                    function: () {
                      goTo(const GroupsView());
                    },
                    text: 'ابدأ',
                    icon: IconlyBroken.send,
                    sizeIcon: 20,
                    radius: 15.0,
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                  child: DefaultButton(
                    function: () {
                      goTo(Coins());
                    },
                    text: 'كسب النقاط',
                    icon: FontAwesomeIcons.coins,
                    coloricon: Colors.amber,
                    sizeIcon: 20,
                    radius: 15.0,
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                  child: DefaultButton(
                    function: () {
                      AppCubit.get(context).showRestartGameConfirm();
                    },
                    text: 'إعادة تشغيل',
                    icon: FontAwesomeIcons.repeat,
                    sizeIcon: 20,
                    radius: 15.0,
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                  child: DefaultButton(
                    function: () {},
                    text: 'قيم اللعبة',
                    icon: IconlyBold.star,
                    coloricon: Colors.amber,
                    sizeIcon: 20,
                    radius: 15.0,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
