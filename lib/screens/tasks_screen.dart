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

class _TasksScreenState extends State<TasksScreen> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                child: AddTaskScreen(
                  onSubmit: Provider.of<TaskListModel>(context, listen: false)
                      .createNewTask,
                ),
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
              ),
            ),
          );
        },
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 60,
              left: 30,
              right: 30,
              bottom: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  child: Icon(
                    Icons.list,
                    size: 30,
                    color: Colors.lightBlueAccent,
                  ),
                  backgroundColor: Colors.white,
                  radius: 30,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Todo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                  ),
                ),
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
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Consumer<TaskListModel>(
                builder: (context, taskModel, child) {
                  return TaskList(
                    taskModel: taskModel,
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
