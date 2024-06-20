import 'package:flutter/material.dart';

class DefaultError extends StatelessWidget {
  const DefaultError({super.key, required this.error});

  final String error;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        error,
        textAlign: TextAlign.center,
      ),
    );
  }
}
