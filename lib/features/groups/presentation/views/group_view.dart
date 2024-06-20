import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:word_game/core/core_widget/default_appbar.dart';
import 'package:word_game/features/groups/presentation/views/widgets/groups_list.dart';

class GroupsView extends StatelessWidget {
  const GroupsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DefaultAppBar(
        text: 'المجموعات',
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            GroupsList(),
          ],
        ),
      ),
    );
  }
}
