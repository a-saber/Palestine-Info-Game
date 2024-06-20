import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:word_game/features/home/presentation/cubit/cache_cubit/cache_cubit.dart';
import 'package:word_game/features/home/presentation/cubit/cache_cubit/cache_state.dart';

import '../resources_manager/colors_manager.dart';
import '../resources_manager/style_manager.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    super.key,
    this.text,
  });
  final String? text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          IconlyBroken.arrowRightCircle,
          color: ColorsManager.black,
        ),
      ),
      title: text != null
          ? Text(text!)
          : BlocBuilder<CacheCubit, CacheState>(builder: ((context, state) {
              if (CacheCubit.get(context).cacheModel != null) {
                return Text(
                  "${CacheCubit.get(context).cacheModel!.questionIndex + 1}",
                );
              }
              return const SizedBox();
            })),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 15),
          child: Row(
            children: [
              BlocBuilder<CacheCubit, CacheState>(builder: ((context, state) {
                if (CacheCubit.get(context).cacheModel != null) {
                  return Text(
                    "${CacheCubit.get(context).cacheModel!.coinsNumber}",
                    style: StyleManager.medium.copyWith(fontSize: 17),
                  );
                }
                return const SizedBox();
              })),
              const SizedBox(
                width: 5,
              ),
              const Icon(
                IconlyBold.star,
                color: ColorsManager.green,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
