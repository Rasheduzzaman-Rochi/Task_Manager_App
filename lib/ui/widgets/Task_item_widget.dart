import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/Task_model.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key, required this.taskModel,
  });

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        tileColor: Colors.white,
        title: Text(taskModel.title ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(taskModel.description ?? ''),
            Text("Date: ${taskModel.createdDate ?? ''}"),
            SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    taskModel.status ?? 'New',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: _getStatusColor(taskModel.status ?? 'New'),
                ),
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status){
    if(status == 'New'){
      return Colors.blue;
    }else if(status == 'Progress'){
      return Colors.yellow;
    }else if(status == 'Cancelled'){
      return Colors.red;
    }else{
      return Colors.green;
    }
  }
}