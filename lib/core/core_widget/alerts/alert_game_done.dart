import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/home/presentation/views/home_view.dart';
import '../../resources_manager/colors_manager.dart';

AlertDialog alertGameDone(context) => AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      content: Builder(builder: (context) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return Container(
          decoration: BoxDecoration(
              color: ColorsManager.white,
              borderRadius: BorderRadius.circular(30)),
          padding:
              EdgeInsets.symmetric(vertical: height * 0.02, horizontal: 20),
          width: width * 0.31,
          height: height * 0.35,
          child: Column(
            children: [
              Icon(
                Icons.celebration,
                size: height > 600 ? 45 : height * 0.06,
                color: Colors.amber,
              ),
              const Spacer(),
              Text("تهانينا لقد قمت باتمام جميع الاسئلة",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: height > 600 ? 28 : height * 0.04,
                      fontWeight: FontWeight.bold)),
              const Spacer(),
              Container(
                width: double.infinity,
                height: height * 0.065,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorsManager.green,
                ),
                child: MaterialButton(
                  onPressed: () {
                    Get.off(const HomeView());
                  },
                  child: Text("القائمة الرئيسية",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: height > 600 ? 28 : height * 0.04,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      }),
    );
