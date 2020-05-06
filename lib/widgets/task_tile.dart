import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String title;
  final void Function(bool) checkboxCallback;
  final void Function() deleteCallback;
  final Key key;

  TaskTile({
    @required this.isChecked,
    @required this.title,
    @required this.checkboxCallback,
    @required this.deleteCallback,
    @required this.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (_) {
        deleteCallback();
      },
      direction: DismissDirection.endToStart,
      key: key,
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
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            decoration: isChecked ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Checkbox(
          value: isChecked,
          activeColor: Colors.lightBlueAccent,
          onChanged: checkboxCallback,
        ),
      ),
    );
  }
}
