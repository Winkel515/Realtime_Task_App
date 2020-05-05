import 'package:flutter/material.dart';
import 'package:todo/models/task_list_model.dart';
import 'package:todo/widgets/task_tile.dart';

class TaskList extends StatelessWidget {
  final TaskListModel taskModel;

  TaskList({@required this.taskModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return TaskTile(
            isChecked: taskModel.getStatus(index),
            title: taskModel.getTitle(index),
            checkboxCallback: (value) {
              taskModel.emitToggleTask(index);
            });
      },
      itemCount: taskModel.getSize(),
    );
  }
}
