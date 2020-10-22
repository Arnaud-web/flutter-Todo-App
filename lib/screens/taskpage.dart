import 'package:app/database_helper.dart';
import 'package:app/models/task.dart';
import 'package:app/models/todo.dart';
import 'package:app/widgets.dart';
import 'package:flutter/material.dart';

class Taskpage extends StatefulWidget {
  final Task task;
  Taskpage({@required this.task});
  @override
  _TaskpageState createState() => _TaskpageState();
}

class _TaskpageState extends State<Taskpage> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  int _taskId = 0;
  String _taskTitle = "";
  String _taskDescription = "";

  FocusNode _titleFocus;
  FocusNode _descriptionFocus;
  FocusNode _todoFocus;

  bool _contentVisible = false;

  @override
  void initState() {
    if (widget.task != null) {
      _contentVisible = true;
      _taskTitle = widget.task.title;
      _taskDescription = widget.task.description;
      _taskId = widget.task.id;
      print("ID ${widget.task.id}");
    }

    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _todoFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _todoFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 24, bottom: 12),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            print("clicked the back bouton");
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Image(
                              image: AssetImage(
                                  'assets/images/back_arrow_icon.png'),
                            ),
                          ),
                        ),
                        Expanded(
                            child: TextField(
                          focusNode: _titleFocus,
                          onSubmitted: (value) async {
                            print("Field value :  $value");
                            if (value != "") {
                              if (widget.task == null) {
                                Task _newTask = Task(title: value);
                                _taskId = await _dbHelper.insertTask(_newTask);
                                print(
                                    "New task has been created ID = $_taskId");
                                setState(() {
                                  _contentVisible = true;
                                  _taskTitle = value;
                                });
                              } else {
                                await _dbHelper.updateTaskTitle(_taskId, value);
                                print("Update existing task");
                              }
                              _descriptionFocus.requestFocus();
                            }
                          },
                          controller: TextEditingController()
                            ..text = _taskTitle,
                          decoration: InputDecoration(
                            hintText: " Enter task title ",
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0XFF211551),
                          ),
                        ))
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _contentVisible,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 12,
                      ),
                      child: TextField(
                        focusNode: _descriptionFocus,
                        onSubmitted: (value) {
                          if (value != "") {
                            if (_taskId != 0) {
                              _dbHelper.updateTaskDescription(_taskId, value);
                            }
                          }
                          _todoFocus.requestFocus();
                        },
                        controller: TextEditingController()
                          ..text = _taskDescription,
                        decoration: InputDecoration(
                          hintText: " Enter Description  ",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 24),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _contentVisible,
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getTodo(_taskId),
                      builder: (context, snapshot) {
                        return Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    // print("ok");
                                    if (snapshot.data.isDone == 0) {
                                      await _dbHelper.updateTodoDone(
                                          snapshot.data.id, 0);
                                    } else {
                                      await _dbHelper.updateTodoDone(
                                          snapshot.data.id, 1);
                                    }
                                    setState(() {});
                                    print(
                                        "todo Done:  ${snapshot.data[index].isDone}");
                                  },
                                  child: TodoWidget(
                                    text: snapshot.data[index].title,
                                    isDone: snapshot.data[index].isDone == 0
                                        ? false
                                        : true,
                                  ),
                                );
                              }),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: _contentVisible,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                margin: EdgeInsets.only(
                                  right: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.5,
                                  ),
                                ),
                                child: Image(
                                  image: AssetImage(
                                      'assets/images/check_icon.png'),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  focusNode: _todoFocus,
                                  onSubmitted: (value) async {
                                    if (value != "") {
                                      if (widget.task != null) {
                                        DatabaseHelper _dbHelper =
                                            DatabaseHelper();
                                        Todo _newTodo = Todo(
                                          title: value,
                                          isDone: 0,
                                          taskId: widget.task.id,
                                        );
                                        await _dbHelper.insertTodo(_newTodo);
                                        setState(() {});
                                        print("New todo has been created");
                                      } else {
                                        print("Update existing todo");
                                      }
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: "inter todo item",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: _contentVisible,
                child: Positioned(
                  bottom: 32.0,
                  right: 24.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Taskpage(
                            task: null,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFF706AE),
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      child: Image(
                          image: AssetImage(
                        "assets/images/delete_icon.png",
                      )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
