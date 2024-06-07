import 'package:flutter/material.dart';
import 'package:word_game/core/resources_manager/colors_manager.dart';
import 'package:word_game/features/groups/presentation/views/widgets/group_view_body.dart';

class GroupsView extends StatelessWidget {
  const GroupsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: GroupViewBody()),
    );
  }
}
