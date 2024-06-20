import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/core/core_widget/default_error.dart';
import 'package:word_game/core/core_widget/default_loading.dart';
import 'package:word_game/core/resources_manager/colors_manager.dart';
import 'package:word_game/core/resources_manager/style_manager.dart';
import 'package:word_game/features/groups/presentation/views/widgets/group_list_item_builder.dart';
import 'package:word_game/features/groups/presentation/cubit/get_group_cubit/get_group_cubit.dart';
import 'package:word_game/features/groups/presentation/cubit/get_group_cubit/get_group_state.dart';

class GroupsList extends StatefulWidget {
  const GroupsList({super.key});

  @override
  State<GroupsList> createState() => _GroupsListState();
}

class _GroupsListState extends State<GroupsList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  double scale = 0.8;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetGroupCubit, GetGroupState>(
        builder: (context, state) {
          Widget result;

          if (state is GetGroupLoadingState) {
            result = const DefaultLoading();
          } else if (state is GetGroupErrorState) {
            result = Expanded(child: DefaultError(error: state.error));
          } else if (state is GetGroupSuccessState ||
              state is GetGroupAllDoneState) {
            result = Expanded(
              child: Column(
                children: [
                  if (state is GetGroupAllDoneState)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        'لقد اتممت جميع مراحل الاسئلة\nانتظر مزيد من الاسئلة في تحديثات قادمة\n ان شاء الله',
                        textAlign: TextAlign.center,
                        style: StyleManager.bold
                            .copyWith(color: ColorsManager.green, fontSize: 25),
                      ),
                    ),
                  GroupListItemBuilder(
                    scale: scale,
                    isAllDone: state is GetGroupAllDoneState,
                  ),
                ],
              ),
            );
          } else {
            result = const SizedBox();
          }

          return result;
        },
        listener: (context, state) {});
  }

  void initAnimation() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _animation = Tween(begin: 0.85, end: 1).animate(_controller)
      ..addStatusListener((status) {})
      ..addListener(() {
        setState(() {
          scale = _animation.value;
        });
      });
    _controller.repeat(reverse: true);
  }
}
