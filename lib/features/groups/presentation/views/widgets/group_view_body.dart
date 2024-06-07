import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:word_game/features/groups/presentation/views/widgets/groups_list.dart';

import '../../../../../core/core_widget/default_appbar.dart';

class GroupViewBody extends StatelessWidget {
  const GroupViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultAppBar(
          text: 'المجموعات',
          icon:IconlyBold.star,
          sizeIcon: 30.0,
          fontSize: 22.0,
          paddingLeft: 0.0,
        ),
        const GroupsList(),
      ],
    );
  }
}
