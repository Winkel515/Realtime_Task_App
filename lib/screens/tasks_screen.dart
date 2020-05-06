import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_list_model.dart';
import 'package:todo/screens/add_task_screen.dart';
import 'package:todo/widgets/task_list.dart';
import 'package:todo/socket/socket.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    socket.on('incoming_task', (taskJSON) {
      Provider.of<TaskListModel>(context, listen: false)
          .createIncomingTask(taskJSON);
    });
    socket.on('incoming_toggle', (taskJSON) {
      Provider.of<TaskListModel>(context, listen: false)
          .incomingToggle(taskJSON);
    });

    socket.on('incoming_task_list', (taskListJSON) {
      Provider.of<TaskListModel>(context, listen: false)
          .populateTasks(taskListJSON);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 80,
              left: 30,
              right: 10,
              bottom: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  'To do',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Consumer<TaskListModel>(
                      builder: (context, tasks, child) {
                        return Text(
                          '${tasks.getSize()} Task${tasks.getSize() > 1 ? 's' : ''}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        );
                      },
                    ),
                    RaisedButton(
                      elevation: 10,
                      shape: CircleBorder(),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Icon(
                          Icons.add,
                          size: 30,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => SingleChildScrollView(
                            child: Container(
                              child: AddTaskScreen(
                                onSubmit: Provider.of<TaskListModel>(context,
                                        listen: false)
                                    .createNewTask,
                              ),
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Consumer<TaskListModel>(
                builder: (context, taskListModel, child) {
                  return TaskList(
                    taskListModel: taskListModel,
                  );
                },
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
