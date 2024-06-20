import 'package:flutter/material.dart';
import 'package:word_game/core/resources_manager/style_manager.dart';

import '../../../../../core/resources_manager/colors_manager.dart';
import '../../../../../core/resources_manager/constant_manager.dart';

class CustomSquare extends StatelessWidget {
  const CustomSquare({
    super.key,
    required this.squareStatus,
    this.text,
    this.enabled = true,
  });

  final SquareStatus squareStatus;
  final String? text;
  final bool enabled;

  final double height = 35;
  final double width = 35;
  final double borderRadius = 5.0;
  final double sampleHeight = 40;
  final double sampleWidth = 40;
  final double fontSize = 15;

  @override
  Widget build(BuildContext context) {
    Color contentColor;
    Color backgroundColor;
    IconData? icon;
    switch (squareStatus) {
      case SquareStatus.answerFull:
        contentColor = ColorsManager.green;
        backgroundColor = ColorsManager.black;
        break;
      case SquareStatus.answerEmpty:
        contentColor = ColorsManager.green;
        backgroundColor = ColorsManager.white;
        break;
      case SquareStatus.suggestButton:
        backgroundColor = enabled
            ? ColorsManager.green
            : ColorsManager.white.withOpacity(0.5);
        contentColor = enabled ? ColorsManager.white : ColorsManager.grey;
        icon = Icons.add;
        break;
      case SquareStatus.deleteButton:
        backgroundColor = enabled
            ? ColorsManager.green
            : ColorsManager.white.withOpacity(0.5);
        contentColor = enabled ? ColorsManager.white : ColorsManager.grey;
        icon = Icons.delete;
        break;
      case SquareStatus.sampleChosen:
        backgroundColor = ColorsManager.white;
        contentColor = ColorsManager.white;
        break;
      default:
        backgroundColor = ColorsManager.black;
        contentColor = ColorsManager.green;
        break;
    }
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius)),
      child: Builder(builder: (context) {
        if (text != null) {
          return Text(text!,
              style: StyleManager.bold
                  .copyWith(fontSize: fontSize, color: contentColor));
        } else {
          return Center(
              child: Icon(
            icon,
            color: contentColor,
          ));
        }
      }),
    );
  }
}
