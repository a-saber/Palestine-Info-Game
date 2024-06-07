import 'package:flutter/material.dart';
import 'package:word_game/core/resources_manager/style_manager.dart';

class DefaultFormField extends StatelessWidget {
  DefaultFormField({
    required this.type,
    required this.controller,
    required this.onChange,
     this.onSubmit,
    this.line=1,
  });

  final TextEditingController controller;
  final TextInputType type;
  Function(String)? onSubmit;
  final Function(String)? onChange;
  int line;
    @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TextFormField(
        textAlign: TextAlign.end,
        controller: controller ,
        keyboardType: type,
        onFieldSubmitted:onSubmit,
         onChanged:onChange ,
         maxLines: line,
        style: TextStyle(
           fontSize: 16.0,
           fontWeight: FontWeight.bold,
           color: Colors.black,
           fontFamily: 'Title',
         ),
        ),
    );
  }
}
