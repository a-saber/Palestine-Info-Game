import 'package:flutter/material.dart';
import 'package:get/get.dart';

void goTo(Widget widget) {
  Get.to(() => widget,
      transition: Transition.leftToRight,
      duration: const Duration(milliseconds: 500));
}
