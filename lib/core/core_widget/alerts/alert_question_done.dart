import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../manager/app_cubit.dart';
import '../../resources_manager/colors_manager.dart';

AlertDialog alertQuestionDone(context) => AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      content: Builder(builder: (context) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          padding:
              EdgeInsets.symmetric(vertical: height * 0.005, horizontal: 10),
          width: width * 0.31,
          height: height * 0.31,
          child: Column(
            children: [
              Icon(
                FontAwesomeIcons.faceSmileBeam,
                size: height > 600 ? 40 : height * 0.04,
                color: ColorsManager.green,
              ),
              const Spacer(),
              Text("+5",
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: height > 600 ? 40 : height * 0.04,
                      fontWeight: FontWeight.bold)),
              const Spacer(),
              Container(
                width: width * 0.5,
                height: height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorsManager.green,
                ),
                child: MaterialButton(
                  onPressed: () {
                    AppCubit.get(context).levelUp().then((value) {
                      Navigator.pop(context);
                    });
                  },
                  child: Text("متابعة",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: height > 600 ? 40 : height * 0.04,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      }),
    );
