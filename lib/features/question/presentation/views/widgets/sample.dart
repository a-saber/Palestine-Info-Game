import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:word_game/core/core_widget/my_snack_bar.dart';
import 'package:word_game/core/resources_manager/delay_manager.dart';
import 'package:word_game/features/groups/presentation/cubit/get_group_cubit/get_group_cubit.dart';
import 'package:word_game/features/home/presentation/cubit/cache_cubit/cache_cubit.dart';
import 'package:word_game/features/home/presentation/views/widgets/coins_view_body.dart';
import 'package:word_game/features/question/data/models/que_up_response.dart';
import 'package:word_game/features/question/presentation/cubit/edit_coins_cubit/edit_coins_cubit.dart';
import 'package:word_game/features/question/presentation/cubit/edit_coins_cubit/edit_coins_state.dart';
import 'package:word_game/features/question/presentation/cubit/question_ui_cubit/question_ui_cubit.dart';
import 'package:word_game/features/question/presentation/cubit/question_ui_cubit/question_ui_state.dart';
import '../../../../../core/resources_manager/colors_manager.dart';
import '../../../../../core/resources_manager/constant_manager.dart';
import 'custom_square.dart';

class Sample extends StatelessWidget {
  const Sample({super.key});

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;

    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: widthScreen * 0.05, vertical: 30.0),
        color: ColorsManager.grey,
        child: BlocConsumer<QuestionUICubit, QuestionUIState>(
            listener: (context, uiState) async {
          if (uiState is SuggestErrorState || uiState is DeleteErrorState) {
            Get.to(const Coins(),
                duration: const Duration(milliseconds: 500),
                transition: DelayManager.rightToLeft);
            callMySnackBar(
                context: context,
                text: 'لا يوجد لديك نقاط كافية\n بامكانك كسب المزيد');
          }
          if (uiState is SuggestState || uiState is DeleteState) {
            await EditCoinsCubit.get(context).editCoins(
              editCoinsType: EditCoinsType.help,
            );
          }
        }, builder: (context, queState) {
          return BlocConsumer<EditCoinsCubit, EditCoinsState>(
              listener: (context, editCoinsState) {
            if (editCoinsState is EditCoinsSuccessState) {
              CacheCubit.get(context)
                  .assignCacheModel(cacheModel: editCoinsState.cacheModel);
              if (!editCoinsState.cacheModel.editMinus) {
                QuestionUICubit.get(context).initQuestion();
              }
            }
          }, builder: (context, editCoinsState) {
            return Column(
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
                          QuestionUICubit.get(context)
                              .question!
                              .charSample
                              .length,
                          (index) => InkWell(
                              onTap: QuestionUICubit.get(context)
                                      .question!
                                      .charSample[index]
                                      .isDeleted
                                  ? null
                                  : !QuestionUICubit.get(context)
                                          .question!
                                          .charSample[index]
                                          .isChosen
                                      ? () {
                                          QuestionUICubit.get(context)
                                              .sampleOnTap(
                                                  indexInSample: index);
                                        }
                                      : null,
                              child: QuestionUICubit.get(context)
                                      .question!
                                      .charSample[index]
                                      .isDeleted
                                  ? const CustomSquare(
                                      squareStatus: SquareStatus.sampleChosen,
                                      enabled: false,
                                    )
                                  : QuestionUICubit.get(context)
                                          .question!
                                          .charSample[index]
                                          .isChosen
                                      ? const CustomSquare(
                                          squareStatus:
                                              SquareStatus.sampleChosen,
                                        )
                                      : CustomSquare(
                                          squareStatus:
                                              SquareStatus.sampleUnChosen,
                                          text: GetGroupCubit.get(context)
                                              .groupResponse!
                                              .group!
                                              .questions[CacheCubit.get(context)
                                                  .cacheModel!
                                                  .questionIndex]
                                              .charSample[index]
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
                              onTap: CacheCubit.get(context)
                                          .cacheModel!
                                          .coinsNumber <
                                      5
                                  ? () {
                                      Get.to(() => const Coins(),
                                          duration:
                                              const Duration(milliseconds: 500),
                                          transition: DelayManager.rightToLeft);
                                    }
                                  : () {
                                      QuestionUICubit.get(context).suggest(
                                          coinsNo: CacheCubit.get(context)
                                              .cacheModel!
                                              .coinsNumber);
                                    },
                              child: CustomSquare(
                                squareStatus: SquareStatus.suggestButton,
                                enabled: !(CacheCubit.get(context)
                                        .cacheModel!
                                        .coinsNumber <
                                    5),
                              )),
                          InkWell(
                              onTap: CacheCubit.get(context)
                                          .cacheModel!
                                          .coinsNumber <
                                      5
                                  ? () {
                                      Get.to(() => const Coins(),
                                          duration:
                                              const Duration(milliseconds: 500),
                                          transition: DelayManager.rightToLeft);
                                    }
                                  : () {
                                      QuestionUICubit.get(context).delete(
                                          coinsNo: CacheCubit.get(context)
                                              .cacheModel!
                                              .coinsNumber);
                                    },
                              child: CustomSquare(
                                squareStatus: SquareStatus.deleteButton,
                                enabled: !(CacheCubit.get(context)
                                        .cacheModel!
                                        .coinsNumber <
                                    5),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          });
        }));
  }
}
