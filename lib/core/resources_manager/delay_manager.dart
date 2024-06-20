import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class DelayManager {
  static const Duration durationOptionsAppear = Duration(milliseconds: 750);
  static Tween<Offset> tweenOptionsAppearAnimation =
      Tween<Offset>(begin: const Offset(0, 3), end: Offset.zero);

  static const Duration durationAnswerAppear = Duration(milliseconds: 800);
  static Tween<Offset> tweenAnswerAppearAnimation =
      Tween<Offset>(begin: const Offset(0, 2), end: Offset.zero);

  static const Transition dowmToUp = Transition.downToUp;
  static const Transition leftToRight = Transition.leftToRight;
  static const Transition rightToLeft = Transition.rightToLeft;
}
