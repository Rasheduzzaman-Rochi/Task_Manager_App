import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/Task_item_widget.dart';
import 'package:task_manager_app/ui/widgets/background_app.dart';
import 'package:task_manager_app/ui/widgets/theme_appBar.dart';

class CompletedTaskListScreen extends StatefulWidget {
  const CompletedTaskListScreen({super.key});

  @override
  State<CompletedTaskListScreen> createState() => _CompletedTaskListScreenState();
}

class _CompletedTaskListScreenState extends State<CompletedTaskListScreen> {
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
          return TaskItemWidget();
        });
  }
}