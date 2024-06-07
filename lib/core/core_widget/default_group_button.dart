import 'package:flutter/material.dart';
import 'package:word_game/core/local/cache_helper_keys.dart';

import '../resources_manager/colors_manager.dart';

class DefaultGroupButton extends StatelessWidget {
  DefaultGroupButton({
    super.key,
    this.groupIndex = 0,
    this.isGroup = false,
    this.icon,
    required this.function,
    required this.text,
    this.width = 250.0,
    this.height = 60.0,
    this.radius = 0.0,
    this.paddingLeft = 15.0,
    this.paddingRight = 35.0,
    this.sizefont = 25.0,
    this.sizeIcon = 10.0,
    this.coloricon = ColorsManager.iconColor,
    this.colorbutton = ColorsManager.buttonColor,
    this.colortext = Colors.white,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  int groupIndex;
  bool isGroup;
  IconData? icon;
  void Function()? function;
  final String text;
  double width;
  double height;
  double sizeIcon;
  double sizefont;
  Color colortext;

  Color coloricon;

  Color colorbutton;

  MainAxisAlignment mainAxisAlignment;
  double radius;
  double paddingLeft;
  double paddingRight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          borderRadius: BorderRadius.circular(radius),
          elevation: 5,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                radius,
              ),
              color: CacheHelperKeys.collectionIndex! >= groupIndex
                  ? ColorsManager.green
                  : ColorsManager.grey,
            ),
            child: Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      text,
                      style: TextStyle(
                        color: colortext,
                        fontSize: sizefont,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
