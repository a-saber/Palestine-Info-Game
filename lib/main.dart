import 'package:flutter/material.dart';
import 'package:word_game/core/app/app.dart';
import 'package:word_game/core/local/cashe_helper.dart';
import 'package:word_game/core/service_manager/service_locator.dart';

late double height;
late double width;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupForgotPassSingleton();
  await CacheHelper.init();
  runApp(const MyApp());
}
