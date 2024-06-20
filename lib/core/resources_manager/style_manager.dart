import 'package:flutter/material.dart';

abstract class StyleConstants {
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}

class StyleManager {
  static const TextStyle extraLight = TextStyle(
    fontWeight: StyleConstants.extraLight,
  );

  static const TextStyle light = TextStyle(
    fontWeight: StyleConstants.extraLight,
  );

  static const TextStyle regular = TextStyle(
    fontWeight: StyleConstants.regular,
  );

  static const TextStyle medium = TextStyle(
    fontWeight: StyleConstants.medium,
  );

  static const TextStyle semiBold = TextStyle(
    fontWeight: StyleConstants.semiBold,
  );

  static const TextStyle bold = TextStyle(
    fontWeight: StyleConstants.bold,
  );

  static const TextStyle extraBold = TextStyle(
    fontWeight: StyleConstants.extraBold,
  );

  static const TextStyle black = TextStyle(
    fontWeight: StyleConstants.black,
  );
}
