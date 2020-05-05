import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:todo/socket/socket.dart';

class TaskListModel extends ChangeNotifier {
  final List<Task> _tasks = [];

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

  void emitToggleTask(int index) {
    socket.emit('toggle_task', _tasks[index].id);
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
    socket.emit('create_task', title);
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
