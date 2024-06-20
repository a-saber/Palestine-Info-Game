import 'package:flutter/material.dart';
import 'package:word_game/core/resources_manager/style_manager.dart';

import '../resources_manager/colors_manager.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {super.key,
      this.onPressed,
      required this.text,
      this.disableColored = false});

  final void Function()? onPressed;
  final String text;
  final bool disableColored;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: double.infinity,
        child: MaterialButton(
          onPressed: onPressed,
          disabledColor:
              disableColored ? ColorsManager.green : ColorsManager.grey,
          color: ColorsManager.green,
          padding: const EdgeInsets.all(10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: StyleManager.medium
                .copyWith(color: ColorsManager.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

/*
class DefaultButton extends StatelessWidget {
  const DefaultButton({
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

  final int groupIndex;
  final bool isGroup;
  final IconData? icon;
  final void Function()? function;
  final String text;
  final double width;
  final double height;
  final double sizeIcon;
  final double sizefont;
  final Color colortext;
  final Color coloricon;
  final Color colorbutton;

  final MainAxisAlignment mainAxisAlignment;
  final double radius;
  final double paddingLeft;
  final double paddingRight;

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
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                radius,
              ),
              color: isGroup
                  ? CacheData.collectionIndex! >= groupIndex
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
*/

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