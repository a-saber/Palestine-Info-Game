import 'package:flutter/material.dart';
import 'package:word_game/core/app/app.dart';
import 'package:word_game/core/functions_manager/init_cash_data.dart';
import 'package:word_game/core/local/cashe_helper.dart';

late double height;
late double width;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  await initCachData();

  runApp(const MyApp());
}
