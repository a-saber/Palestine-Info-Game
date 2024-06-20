import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/core/core_widget/alerts/alert_suc_get_coins.dart';
import 'package:word_game/core/core_widget/default_appbar.dart';
import 'package:word_game/core/core_widget/my_snack_bar.dart';
import 'package:word_game/core/resources_manager/colors_manager.dart';
import 'package:word_game/core/resources_manager/style_manager.dart';
import 'package:word_game/features/home/presentation/cubit/cache_cubit/cache_cubit.dart';
import 'package:word_game/features/question/data/models/que_up_response.dart';
import 'package:word_game/features/question/presentation/cubit/edit_coins_cubit/edit_coins_cubit.dart';
import 'package:word_game/features/question/presentation/cubit/edit_coins_cubit/edit_coins_state.dart';

class GetPointsView extends StatefulWidget {
  const GetPointsView({super.key, required this.title});

  final String title;

  @override
  State<GetPointsView> createState() => _GetPointsViewState();
}

class _GetPointsViewState extends State<GetPointsView> {
  int clicksNo = 0;
  @override
  void initState() {
    clicksNo = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(text: 'كسب نقاط'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${widget.title} 10 مرات \n و أحصل على 5 نقاط',
              textAlign: TextAlign.center,
              style: StyleManager.black.copyWith(fontSize: 25),
            ),
            const SizedBox(
              height: 100,
            ),
            BlocConsumer<EditCoinsCubit, EditCoinsState>(
              listener: (context, state) async {
                if (state is EditCoinsErrorState) {
                  callMySnackBar(context: context, text: state.error);
                } else if (state is EditCoinsSuccessState) {
                  CacheCubit.get(context)
                      .assignCacheModel(cacheModel: state.cacheModel);
                  showDialog(
                      context: context,
                      builder: (BuildContext ctx) => alertSuccGetCoins(context),
                      barrierDismissible: false);
                }
              },
              builder: (context, state) => ClipOval(
                child: Material(
                  color: ColorsManager.green, // Button coloor
                  child: InkWell(
                    onTap: () {
                      clicksNo++;
                      setState(() {});
                      if (clicksNo == 10) {
                        EditCoinsCubit.get(context)
                            .editCoins(editCoinsType: EditCoinsType.praise);
                      }
                    },
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.title,
                            textAlign: TextAlign.center,
                            style: StyleManager.medium.copyWith(
                                color: ColorsManager.white, fontSize: 20),
                          ),
                          Text(
                            '$clicksNo',
                            textAlign: TextAlign.center,
                            style: StyleManager.medium.copyWith(
                                color: ColorsManager.white, fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
