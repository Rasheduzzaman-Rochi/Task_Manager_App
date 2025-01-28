import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_app/ui/widgets/SummeryCounterWidget.dart';
import 'package:task_manager_app/ui/widgets/Task_item_widget.dart';
import 'package:task_manager_app/ui/widgets/background_app.dart';
import 'package:task_manager_app/ui/widgets/theme_appBar.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: background(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTaskSummaryByStatus(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _listViewBuilder(),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNewTaskScreen.name);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _listViewBuilder() {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: 10,
        itemBuilder: (context, index) {
          return TaskItemWidget();
        });
  }

  Widget _buildTaskSummaryByStatus() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            TaskStatusSummaryCounter(
              title: 'Completed',
              count: '12',
            ),
            TaskStatusSummaryCounter(
              title: 'Ongoing',
              count: '2',
            ),
            TaskStatusSummaryCounter(
              title: 'Pending',
              count: '5',
            ),
            TaskStatusSummaryCounter(
              title: 'Archived',
              count: '3',
            )
          ],
        ),
      ),
    );
  }
}
