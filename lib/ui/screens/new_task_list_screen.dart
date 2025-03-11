import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/task_count_model.dart';
import 'package:task_manager_app/data/models/task_count_status_model.dart';
import 'package:task_manager_app/data/models/task_list_by_status_model.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_app/ui/widgets/SummeryCounterWidget.dart';
import 'package:task_manager_app/ui/widgets/Task_item_widget.dart';
import 'package:task_manager_app/ui/widgets/background_app.dart';
import 'package:task_manager_app/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';
import 'package:task_manager_app/ui/widgets/theme_appBar.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  bool _getTaskCountByStatusInProgress = false;
  bool _getNewTaskListInProgress = false;
  TaskCountByStatusModel? taskCountByStatusModel;
  TaskListByStatusModel? newTaskListModel;

  @override
  void initState() {
    super.initState();
    _getTaskCountByStatus();
    _getNewTaskList();
  }

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
                child: Visibility(visible: _getNewTaskListInProgress == false,
                replacement: CenterCircularProgressIndicator(),
                child: _listViewBuilder()),
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
        itemCount: newTaskListModel?.taskList?.length ?? 0,
        itemBuilder: (context, index) {
          return TaskItemWidget(
              taskModel: newTaskListModel!.taskList![index]);
        });
  }

  Widget _buildTaskSummaryByStatus() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Visibility(
        visible: _getTaskCountByStatusInProgress == false,
        replacement: CircularProgressIndicator(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: taskCountByStatusModel?.taskByStatusList?.length ?? 0,
                itemBuilder: (Context, index) {
                  final TaskCountModel model =
                      taskCountByStatusModel!.taskByStatusList![index];
                  return TaskStatusSummaryCounter(
                      title: model.sId ?? '', count: model.sum.toString());
                }),
          ),
        ),
      ),
    );
  }

  Future<void> _getTaskCountByStatus() async {
    _getTaskCountByStatusInProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskCountByStatusUrl);
    if (response.isSuccess) {
      taskCountByStatusModel =
          TaskCountByStatusModel.fromJson(response.responseData!);
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
    _getTaskCountByStatusInProgress = false;
    setState(() {});
  }

  Future<void> _getNewTaskList() async {
    _getNewTaskListInProgress = true;
    setState(() {});
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.taskListByStatusUrl("New"));
    if (response.isSuccess) {
      newTaskListModel =
          TaskListByStatusModel.fromJson(response.responseData!);
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
    _getNewTaskListInProgress = false;
    setState(() {});
  }
}