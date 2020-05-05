import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  final void Function(String) onSubmit;

  AddTaskScreen({this.onSubmit});

  @override
  Widget build(BuildContext context) {
    String newTaskTitle;
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 30,
              ),
            ),
            TextField(
              textCapitalization: TextCapitalization.sentences,
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                newTaskTitle = value;
              },
            ),
            FlatButton(
              color: Colors.lightBlueAccent,
              onPressed: () {
                onSubmit(newTaskTitle);
                Navigator.pop(context);
              },
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
      ),
    );
  }
}
