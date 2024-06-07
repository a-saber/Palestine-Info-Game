import 'package:flutter/material.dart';

import '../../../../../core/resources_manager/colors_manager.dart';
import '../../../../../core/resources_manager/constant_manager.dart';

class CustomSquare extends StatelessWidget {
  CustomSquare({
    Key? key,
    required this.squareStatus,
    this.text = "",
    this.deleteTap = false,
    this.suggestTap = false,
  }) : super(key: key);

  final SquareStatus squareStatus;
  final String text;
  final bool suggestTap;
  final bool deleteTap;

  final double answerCharPadding = 8.0;

  final IconData suggestIcon = Icons.add;
  final IconData deleteIcon = Icons.delete;

  final double height = 35;
  final double width = 35;
  final double borderRadius = 5.0;
  final double sampleHeight = 40;
  final double sampleWidth = 40;

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    const TextStyle answerStyle = TextStyle(
        color: ColorsManager.fullAnswerTextColor,
        fontWeight: FontWeight.bold,
        fontSize: 15);
    TextStyle sampleStyle = const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: ColorsManager.unChosenSampleTextColor);

    if (squareStatus == SquareStatus.answerFull) {
      return Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: ColorsManager.black,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Text(text, style: answerStyle),
      );
    } else if (squareStatus == SquareStatus.answerEmpty) {
      return Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: ColorsManager.white,
            borderRadius: BorderRadius.circular(borderRadius)),
      );
    } else if (squareStatus == SquareStatus.deleteButton) {
      return Container(
        alignment: Alignment.center,
        height: sampleHeight,
        width: sampleWidth,
        decoration: BoxDecoration(
            color: deleteTap
                ? ColorsManager.sampleBackgroundColor
                : ColorsManager.buttonBackgroundColor,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Center(
            child: Icon(
          deleteIcon,
          color: deleteTap
              ? ColorsManager.sampleBackgroundColor
              : ColorsManager.buttonIconColor,
        )),
      );
    } else if (squareStatus == SquareStatus.suggestButton) {
      return Container(
        alignment: Alignment.center,
        height: sampleHeight,
        width: sampleWidth,
        decoration: BoxDecoration(
            color: suggestTap
                ? ColorsManager.sampleBackgroundColor
                : ColorsManager.buttonBackgroundColor,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Center(
            child: Icon(
          suggestIcon,
          color: suggestTap
              ? ColorsManager.sampleBackgroundColor
              : ColorsManager.buttonIconColor,
        )),
      );
    } else if (squareStatus == SquareStatus.sampleChosen) {
      return Container(
        alignment: Alignment.center,
        height: sampleHeight,
        width: sampleWidth,
        decoration: BoxDecoration(
            color: ColorsManager.chosenSampleColor,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Center(
          child: Text(text, style: sampleStyle),
        ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        height: sampleHeight,
        width: sampleWidth,
        decoration: BoxDecoration(
            color: ColorsManager.black,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Center(
          child: Text(text, style: sampleStyle),
        ),
      );
    }
  }
}
