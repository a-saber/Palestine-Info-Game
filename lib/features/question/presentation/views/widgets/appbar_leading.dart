import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../../../../core/resources_manager/colors_manager.dart';

class AppbarLeading extends StatelessWidget {
  const AppbarLeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              IconlyBroken.arrowLeftCircle,
              color: ColorsManager.black,
              size: 30.0,
            ),
            SizedBox(
              width: 5,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'رجوع',
                style: TextStyle(
                  fontSize: 22.0,
                  color: ColorsManager.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
