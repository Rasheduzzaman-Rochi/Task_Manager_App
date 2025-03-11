import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/Task_model.dart';
import 'package:task_manager_app/ui/widgets/Task_item_widget.dart';
import 'package:task_manager_app/ui/widgets/background_app.dart';
import 'package:task_manager_app/ui/widgets/theme_appBar.dart';

class CancelTaskListScreen extends StatefulWidget {
  const CancelTaskListScreen({super.key});

  @override
  State<CancelTaskListScreen> createState() => _CancelTaskListScreenState();
}

class _CancelTaskListScreenState extends State<CancelTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: background(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: _listViewBuilder(),
        ),
      ),
    );
  }

  Widget _listViewBuilder() {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return TaskItemWidget(taskModel: TaskModel());
        });
  }
}