import 'package:flutter/material.dart';
import 'package:word_game/core/local/cache_helper_keys.dart';

import '../resources_manager/colors_manager.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({
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
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                radius,
              ),
              color: isGroup
                  ? CacheHelperKeys.collectionIndex! >= groupIndex
                      ? Colors.amber
                      : ColorsManager.green
                  : ColorsManager.green,
            ),
            child: Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
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


/*
isGroup
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            if (CacheHelperKeys.collectionIndex! ==
                                    groupIndex &&
                                CacheHelperKeys.solvedNumber! > index) {
                              return const Icon(
                                Icons.star_rounded,
                                color: Colors.white,
                              );
                            }
                            if (CacheHelperKeys.collectionIndex! > groupIndex) {
                              return Icon(
                                Icons.star_rounded,
                                color: CacheHelperKeys.collectionIndex! >
                                        groupIndex
                                    ? Colors.white
                                    : CacheHelperKeys.collectionIndex! ==
                                            groupIndex
                                        ? CacheHelperKeys.solvedNumber! > index
                                            ? Colors.amber
                                            : Colors.white
                                        : Colors.transparent,
                              );
                            }

                            return Icon(
                              Icons.star_border,
                              color: CacheHelperKeys.collectionIndex! >
                                      groupIndex
                                  ? Colors.white
                                  : CacheHelperKeys.collectionIndex! ==
                                          groupIndex
                                      ? ((CacheHelperKeys.solvedNumber!) / 2)
                                                  .floor() >
                                              index
                                          ? Colors.amber
                                          : Colors.white
                                      : Colors.transparent,
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                width: 0.0,
                              ),
                          itemCount: 5),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                          right: paddingRight, left: paddingLeft),
                      child: Icon(
                        icon,
                        size: sizeIcon,
                        color: coloricon,
                      ),
                    ),
*/