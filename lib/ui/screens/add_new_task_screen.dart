import 'package:flutter/material.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/widgets/background_app.dart';
import 'package:task_manager_app/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';
import 'package:task_manager_app/ui/widgets/theme_appBar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  static const String name = '/add-new-task-screen';

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _addNewTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: TMAppBar(),
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: background(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 32,
                ),
                Text("Add New Task", style: textTheme.titleLarge),
                SizedBox(height: 16),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(hintText: 'Title'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter your title here";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 6,
                  decoration: InputDecoration(hintText: 'Description'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter your description here";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Visibility(
                  visible: _addNewTaskInProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        _createNewTask();
                      }
                    },
                    child: Icon(Icons.arrow_circle_right_outlined,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Future<void> _createNewTask() async {
    _addNewTaskInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "title": _titleController.text.trim(),
      "description": _descriptionController.text.trim(),
      "status": "New"
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.createTaskUrl, body: requestBody);
    _addNewTaskInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _clearTextField();
      showSnackBarMessage(context, "Task created successfully");
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
  }

  void _clearTextField() {
    _titleController.clear();
    _descriptionController.clear();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}