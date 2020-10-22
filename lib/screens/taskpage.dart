import 'package:app/database_helper.dart';
import 'package:app/models/task.dart';
import 'package:app/widgets.dart';
import 'package:flutter/material.dart';

class Taskpage extends StatefulWidget {
  @override
  _TaskpageState createState() => _TaskpageState();
}

class _TaskpageState extends State<Taskpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                   Padding(
                     padding: EdgeInsets.only(
                       top: 24,
                       bottom: 12
                     ),
                     child: Row(
                       children: [
                         InkWell(
                           onTap: (){
                             print("clicked the back bouton");
                             Navigator.pop(context);
                           },
                            child: Padding(
                             padding: const EdgeInsets.all(30.0),
                             child: Image(image: AssetImage(
                               'assets/images/back_arrow_icon.png'
                             ),
                             ),
                           ),
                         ),
                         Expanded(child: TextField(
                           onSubmitted: (value) async {
                             print("Field value :  $value");
                             if (value != ""){
                                DatabaseHelper _dbHelper = DatabaseHelper();
                                Task _newTask = Task(
                                  title: value
                                );
                                await _dbHelper.insertTask(_newTask);
                                print("New task has been created");
                             }
                           },
                           decoration: InputDecoration(
                             hintText: " Enter task title ",
                             border: InputBorder.none,
                           ),
                           style: TextStyle(
                             fontSize: 26.0,
                             fontWeight: FontWeight.bold,
                             color: Color( 0XFF211551 ),
                           ),
                         ))
                       ],
                     ),
                   ),
                 Padding(
                   padding: EdgeInsets.only(
                     bottom: 12,
                   ),
                   child: TextField(
                     decoration: InputDecoration(
                        hintText: " Enter Description  " ,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 24
                        ),
                      ),
                   ),
                 ),
                 TodoWidget(
                   text: "Create your first task ! ",
                   isDone: false,
                 ),
                 TodoWidget(
                   text: "Create your first todo",
                   isDone: false,
                 ),
                 TodoWidget(
                   isDone: true,
                 ),
                ],
              ),
              Positioned (
                bottom: 32.0,
                right:24.0,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => Taskpage(),
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
                      )
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
