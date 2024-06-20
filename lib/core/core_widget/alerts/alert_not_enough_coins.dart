import 'package:flutter/material.dart';

import '../../resources_manager/colors_manager.dart';

AlertDialog alertNotEnoughCoins(context) => AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      content: Builder(
        builder: (context) {
          // Get available height and width of the build area of this widget. Make a choice depending on the size.
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: ColorsManager.grey, width: 3.0),
              color: ColorsManager.black,
            ),
            padding:
                EdgeInsets.symmetric(vertical: height * 0.005, horizontal: 10),
            width: width * 0.31,
            height: height * 0.31,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'يجب ان يكون لديك 5 نقاط',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: height > 600 ? 33 : height * 0.04,
                    color: ColorsManager.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // color:ColorsManager.textAnswerColor,
                          color: Colors.red,

                          border:
                              Border.all(color: ColorsManager.grey, width: 3.0),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            /*
                            AppCubit.get(context).restartGame().then((value)
                            {
                              Navigator.pop(context);
                              goTo(Coins());
                            });*/
                          },
                          child: const Text("اربح نقاط",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorsManager.green,
                          border:
                              Border.all(color: ColorsManager.grey, width: 3.0),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "حسنا",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
