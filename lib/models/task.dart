import 'package:flutter/cupertino.dart';

class Task {
  final String title;
  final String id;
  bool status;

  Task({@required this.title, this.status = false, @required this.id});

  void toggleTask() {
    status = !status;
  }
}
