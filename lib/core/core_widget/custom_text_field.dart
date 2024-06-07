import 'package:flutter/material.dart';
import 'package:word_game/core/resources_manager/style_manager.dart';

import '../resources_manager/colors_manager.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {required this.label,
      this.icon,
      required this.controller,
      required this.type,
      this.suffix,
      this.suffixPressed,
      this.cursorColor,
      this.cursorRadius,
      this.iconColor,
      this.labelColor,
      this.isPassword = false,
      this.onChange,
      this.onSubmit,
      this.maxLines = 1});

  final int maxLines;
  final String label;
  final IconData? icon;
  TextEditingController controller;
  final TextInputType type;
  IconData? suffix;
  Function()? suffixPressed;
  Color? cursorColor;
  Radius? cursorRadius;
  Color? iconColor;
  Color? labelColor;
  Function(String)? onSubmit;
  Function(String)? onChange;
  bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(5.0)),
      //width: 00,
      //padding: const EdgeInsets.only(left: 20.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          textAlign: TextAlign.right,
          maxLines: maxLines,
          style: StyleManager.normal.copyWith(fontSize: 20),
          textDirection: TextDirection.rtl,
          controller: controller,
          keyboardType: type,
          obscureText: isPassword,
          onFieldSubmitted: onSubmit,
          onChanged: onChange,
          validator: (String? value) {
            if (value.toString().isEmpty || value == null)
              return "Mustn't Be Empty";
            return null;
          },
          decoration: InputDecoration(
            labelText: label,

            labelStyle: StyleManager.normal.copyWith(color: Colors.grey),
            contentPadding: const EdgeInsets.all(15),
            border: InputBorder.none,

            // hintText: label,
            //hintStyle: StyleManager.normal.copyWith(color: Colors.grey),
            //hintTextDirection: TextDirection.rtl,
            focusColor: ColorsManager.green,
          ),
          cursorColor: cursorColor,
          cursorRadius: cursorRadius,
        ),
      ),
    );
  }
}
