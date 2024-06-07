import 'package:flutter/material.dart';

class QuestionImageView extends StatelessWidget {
  const QuestionImageView({Key? key, required this.image}) : super(key: key);

  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          image: DecorationImage(image: AssetImage(image),fit: BoxFit.fill)
        ),
      ),
    );
  }
}
