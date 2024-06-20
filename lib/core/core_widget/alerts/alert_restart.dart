import 'package:flutter/material.dart';
import 'package:word_game/core/resources_manager/style_manager.dart';
import 'package:word_game/features/question/presentation/cubit/restart_cubit/restart_cubit.dart';
import '../../resources_manager/colors_manager.dart';

AlertDialog alertRestart(context) => AlertDialog(
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
              color: ColorsManager.white,
            ),
            padding:
                EdgeInsets.symmetric(vertical: height * 0.005, horizontal: 10),
            width: width * 0.31,
            height: height * 0.31,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'هل تريد اعادة تشغيل اللعبة ؟',
                  textAlign: TextAlign.center,
                  style: StyleManager.medium.copyWith(
                    fontSize: 25,
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
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            RestartCubit.get(context).restart();
                            Navigator.pop(context);
                          },
                          child: Text("نعم",
                              style: StyleManager.medium.copyWith(
                                color: Colors.white,
                                fontSize: 19,
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
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "لا",
                            style: StyleManager.medium.copyWith(
                              color: Colors.white,
                              fontSize: 19,
                            ),
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
