import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:todo/socket/socket.dart';

class Task {
  String title;
  final String id;
  bool status;

  Task({
    @required this.title,
    this.status = false,
    @required this.id,
  });

  void toggleTask() {
    status = !status;
  }

  void emitToggleTask() {
    socket.emit('toggle_task', id);
  }

  void emitDeleteTask() {
    socket.emit('delete_task', id);
  }

  void emitEditTask(String newTitle) {
    title = newTitle;
    socket.emit('edit_task', jsonEncode(this.toMap()));
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      '_id': id,
      'status': status,
    };
  }
}
