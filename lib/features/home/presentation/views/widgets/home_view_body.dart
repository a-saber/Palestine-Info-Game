import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:word_game/core/resources_manager/assets_manager.dart';
import 'package:word_game/core/resources_manager/constant_manager.dart';
import 'package:word_game/core/resources_manager/delay_manager.dart';
import 'package:word_game/core/resources_manager/style_manager.dart';
import 'package:word_game/features/home/presentation/views/widgets/home_options.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ConstantManager.appName,
                style: StyleManager.bold.copyWith(fontSize: 40),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Image.asset(
                  AssetsManager.palestineFlag,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: HomeOptions(
              slidingAnimation: slidingAnimation,
            ),
          )
        ],
      ),
    );
  }

  void initAnimation() {
    animationController = AnimationController(
        vsync: this, duration: DelayManager.durationOptionsAppear);
    slidingAnimation =
        DelayManager.tweenOptionsAppearAnimation.animate(animationController);
    animationController.forward();
    slidingAnimation.addListener(() {
      setState(() {});
    });
  }
}
