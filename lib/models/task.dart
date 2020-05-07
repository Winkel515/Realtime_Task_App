import 'package:flutter/cupertino.dart';

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

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      '_id': id,
      'status': status,
    };
  }
}
