import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:todo/socket/socket.dart';
import 'package:todo/widgets/task_tile.dart';

class TaskListModel extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<TaskTile> generateTaskTiles() {
    List<TaskTile> tasksTiles = [];
    for (Task task in _tasks) {
      tasksTiles.add(
        TaskTile(
          isChecked: task.status,
          title: task.title,
          checkboxCallback: (value) {
            task.emitToggleTask();
          },
          deleteCallback: task.emitDeleteTask,
          key: Key(task.id),
        ),
      );
    }
    return tasksTiles;
  }

  void populateTasks(String taskListJSON) {
    _tasks.clear();
    var taskList = jsonDecode(taskListJSON);
    for (Map<String, dynamic> task in taskList) {
      _tasks.add(
        Task(
          title: task['title'],
          id: task['_id'],
          status: task['status'],
        ),
      );
    }
    notifyListeners();
  }

  void swapTasks(int oldIndex, int newIndex) {
    _tasks.insert(newIndex, _tasks[oldIndex]);
    if (newIndex < oldIndex) {
      _tasks.removeAt(oldIndex + 1);
    } else {
      _tasks.removeAt(oldIndex);
    }
    notifyListeners();
    String jsonTasks = jsonEncode(_tasks.map((task) => task.toMap()).toList());
    socket.emit('reorder_task', jsonTasks);
  }

  void incomingToggle(String taskJSON) {
    var decodedTask = jsonDecode(taskJSON);
    for (Task task in _tasks) {
      if (task.id == decodedTask['_id']) {
        task.status = decodedTask['status'];
        break;
      }
    }
    notifyListeners();
  }

  // For creating a new task that will be broadcast
  void createNewTask(String title) {
    socket.emit(
      'create_task',
      jsonEncode(
        <String, dynamic>{
          'title': title,
          'index': _tasks.length,
        },
      ),
    );
  }

  void createIncomingTask(String taskJSON) {
    var decodedTask = jsonDecode(taskJSON);
    _tasks.add(Task(
      id: decodedTask['_id'],
      title: decodedTask['title'],
      status: decodedTask['status'],
    ));
    notifyListeners();
  }

  String getTitle(int index) {
    return _tasks[index].title;
  }

  bool getStatus(int index) {
    return _tasks[index].status;
  }

  int getSize() {
    return _tasks.length;
  }
}
