import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:word_game/core/core_widget/default_group_button.dart';
import 'package:word_game/core/local/cache_helper_keys.dart';
import 'package:word_game/core/manager/app_cubit.dart';
import 'package:word_game/core/manager/app_states.dart';

import '../../../../../core/core_widget/default_button.dart';
import '../../../../question/presentation/views/question_view.dart';

class GroupsList extends StatefulWidget {
  const GroupsList({Key? key}) : super(key: key);

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
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemBuilder: (context, int index) {
                return Transform.scale(
                  scale: CacheHelperKeys.collectionIndex == index ? scale : 1,
                  origin: const Offset(50, 50),
                  child: DefaultGroupButton(
                    function: CacheHelperKeys.collectionIndex == index
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const QuestionView()),
                            );
                          }
                        : null,
                    text: "المجموعة" + "    " + (index + 1).toString(),
                    width: 400,
                    radius: 10.0,
                    icon: IconlyLight.star,
                    sizeIcon: 20.0,
                    isGroup: true,
                    groupIndex: index,
                  ),
                );
              },
              separatorBuilder: (context, int index) =>
                  const SizedBox(height: 8.0),
              itemCount: AppCubit.get(context).collections.length,
            ),
          );
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
        print(_animation.value);
      });
    _controller.repeat(reverse: true);
  }
}
