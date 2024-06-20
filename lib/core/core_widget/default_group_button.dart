import 'package:flutter/material.dart';
import 'package:word_game/core/core_widget/default_button.dart';

class DefaultGroupButton extends StatelessWidget {
  const DefaultGroupButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.disableColored = false,
  });

  final void Function()? onPressed;
  final String text;
  final bool disableColored;

  @override
  Widget build(BuildContext context) {
    return DefaultButton(
      text: text,
      onPressed: onPressed,
      disableColored: disableColored,
    );
  }
}
