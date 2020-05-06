import 'package:flutter/material.dart';
import 'package:todo/models/task_list_model.dart';

class TaskList extends StatelessWidget {
  final TaskListModel taskListModel;

  TaskList({@required this.taskListModel});

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      children: taskListModel.generateTaskTiles(),
      onReorder: taskListModel.swapTasks,
      header: SizedBox(
        height: 40,
      ),
    );
  }
}
