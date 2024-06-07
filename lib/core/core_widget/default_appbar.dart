import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:word_game/core/local/cache_helper_keys.dart';
import 'package:word_game/core/manager/app_cubit.dart';
import 'package:word_game/core/manager/app_states.dart';

import '../resources_manager/colors_manager.dart';
import '../resources_manager/style_manager.dart';

class DefaultAppBar extends StatelessWidget {
  DefaultAppBar({
    super.key,
    required this.text,
    this.sizeIcon = 30.0,
    this.coloricon = ColorsManager.iconColor,
    this.colortext = Colors.white,
    this.icon,
    this.fontSize = 16.0,
    this.paddingLeft = 8.0,
    this.paddingRight = 8.0,
  });
  final String text;
  double sizeIcon;
  Color colortext;
  Color coloricon;
  IconData? icon;
  double fontSize;
  double paddingLeft;
  double paddingRight;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return AppBar(
            elevation: 0.0,
            leading: Padding(
              padding: const EdgeInsetsDirectional.only(start: 10.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      IconlyBroken.arrowLeftCircle,
                      color: ColorsManager.black,
                      size: sizeIcon,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'رجوع',
                      style: TextStyle(
                          fontSize: fontSize, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ),
            leadingWidth: 100.0,
            title: Text(
              text,
              style: StyleManager.normal.copyWith(fontSize: 24),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 10),
                child: Row(
                  children: [
                    Text(
                      "${CacheHelperKeys.solvedNumber! + (CacheHelperKeys.collectionIndex! * 10)}",
                      style: StyleManager.normal,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(
                      icon,
                      color: ColorsManager.green,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        listener: (context, state) {});
  }
}
