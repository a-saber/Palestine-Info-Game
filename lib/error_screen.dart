import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('sorry, it\'s not working', style: TextStyle(color: Colors.blueAccent, fontSize: 40), textAlign: TextAlign.center,),
      ),
    );
  }
}
