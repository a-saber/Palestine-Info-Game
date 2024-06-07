import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/core_widget/alerts/alert_not_enough_coins.dart';
import '../../../../../core/core_widget/alerts/alert_question_done.dart';
import '../../../../../core/local/cache_helper_keys.dart';
import '../../../../../core/manager/app_cubit.dart';
import '../../../../../core/manager/app_states.dart';
import '../../../../../core/resources_manager/colors_manager.dart';
import '../../../../../core/resources_manager/constant_manager.dart';
import 'custom_square.dart';

class Sample extends StatelessWidget {
  const Sample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;

    return BlocConsumer<AppCubit, AppStates>(builder: (context, state) {
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: widthScreen * 0.05, vertical: 15.0),
        color: ColorsManager.sampleBackgroundColor,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: widthScreen > heightScreen
                      ? widthScreen * 0.4
                      : widthScreen * 0.7,
                  child: GridView.count(
                    reverse: true,
                    shrinkWrap: true,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 15.0,
                    childAspectRatio: 1,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 6,
                    children: List.generate(
                      AppCubit.get(context)
                          .collections[CacheHelperKeys.collectionIndex!]
                          .questions[CacheHelperKeys.questionIndex!]
                          .characters
                          .length,
                      (index) => InkWell(
                          onTap: !AppCubit.get(context)
                                  .collections[CacheHelperKeys.collectionIndex!]
                                  .questions[CacheHelperKeys.questionIndex!]
                                  .characters[index]
                                  .isChosen
                              ? () {
                                  AppCubit.get(context).sampleOnTap(index);
                                }
                              : null,
                          child: AppCubit.get(context)
                                  .collections[CacheHelperKeys.collectionIndex!]
                                  .questions[CacheHelperKeys.questionIndex!]
                                  .characters[index]
                                  .isChosen
                              ? CustomSquare(
                                  squareStatus: SquareStatus.sampleChosen)
                              : CustomSquare(
                                  squareStatus: SquareStatus.sampleUnChosen,
                                  text: AppCubit.get(context)
                                      .collections[
                                          CacheHelperKeys.collectionIndex!]
                                      .questions[CacheHelperKeys.questionIndex!]
                                      .characters[index]
                                      .char,
                                )),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: widthScreen > heightScreen
                      ? widthScreen * 0.058
                      : widthScreen * 0.1,
                  child: GridView.count(
                    reverse: true,
                    shrinkWrap: true,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 15.0,
                    childAspectRatio: 1,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 1,
                    children: [
                      InkWell(
                          onTap: AppCubit.get(context).suggest
                              ? null
                              : AppCubit.get(context).suggestOne,
                          child: CustomSquare(
                            squareStatus: SquareStatus.suggestButton,
                            suggestTap: AppCubit.get(context).suggest,
                          )),
                      InkWell(
                          onTap: AppCubit.get(context).remove
                              ? null
                              : AppCubit.get(context).removeTwo,
                          child: CustomSquare(
                            squareStatus: SquareStatus.deleteButton,
                            deleteTap: AppCubit.get(context).remove,
                          )),
                    ],
                  ),
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children:
                //   [
                //     InkWell(
                //         onTap: AppCubit.get(context).suggest ? null : AppCubit.get(context).suggestOne,
                //         child: CustomSquare(squareStatus: SquareStatus.suggestButton, suggestTap: AppCubit.get(context).suggest ,)
                //     ),
                //     const SizedBox(height: 15,),
                //     InkWell(
                //         onTap: AppCubit.get(context).remove ? null : AppCubit.get(context).removeTwo,
                //         child: CustomSquare(squareStatus: SquareStatus.deleteButton, deleteTap: AppCubit.get(context).remove,)
                //
                //     ),
                //   ],
                // ),
              ],
            ),
          ],
        ),
      );
    }, listener: (context, state) {
      if (state is ShowContinueLevelUpState) {
        showDialog(
          context: context,
          builder: (BuildContext ctx) => alertQuestionDone(context),
          barrierDismissible: false,
        );
      }
      if (state is ShowNotEnoughCoinsState) {
        showDialog(
          context: context,
          builder: (BuildContext ctx) => alertNotEnoughCoins(context),
          barrierDismissible: false,
        );
      }
    });
  }
}
