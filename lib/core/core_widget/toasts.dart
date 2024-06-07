import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';

enum ToastStates { SUCCESS, ERRORINFO, ERRORCONNECT, INFO }

Color? ChooseColor(ToastStates state) {
  Color? color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green.withOpacity(0.7);
      break;
    case ToastStates.ERRORINFO:
      color = Colors.red;
      break;
    case ToastStates.ERRORCONNECT:
      color = Colors.amber;
      break;
    case ToastStates.INFO:
      color = Colors.black;
      break;
  }
  return color;
}

void makeToast({
  required String msg,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: ChooseColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}
