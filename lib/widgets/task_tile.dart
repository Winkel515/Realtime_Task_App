import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:todo/models/task_list_model.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Key key;
  final TaskListModel taskListModel;

  TaskTile({
    @required this.task,
    @required this.key,
    @required this.taskListModel,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (_) {
        taskListModel.deleteTask(task);
      },
      direction: DismissDirection.endToStart,
      key: key,
      child: ListTile(
        title: GestureDetector(
          onDoubleTap: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  TextEditingController controller =
                      new TextEditingController(text: task.title);
                  return AlertDialog(
                    title: Text('Edit Task'),
                    content: SingleChildScrollView(
                      child: TextField(
                        controller: controller,
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Cancel'),
                        color: Colors.red,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: Text('Submit'),
                        color: Colors.green,
                        onPressed: () {
                          if (controller.text.trim() != task.title)
                            taskListModel.editTask(
                              task: task,
                              newTitle: controller.text.trim(),
                            );
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                });
          },
          child: Text(
            task.title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              decoration: task.status ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
        trailing: Checkbox(
          value: task.status,
          activeColor: Colors.lightBlueAccent,
          onChanged: (_) => taskListModel.toggleTask(task),
        ),
      ),
      background: Container(
        padding: EdgeInsets.only(right: 30),
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              'DELETE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.delete_forever,
              color: Colors.white,
              size: 35,
            ),
          ],
        ),
      ),
    );
  }
}
