import 'package:app/database_helper.dart';
import 'package:app/screens/taskpage.dart';
import 'package:app/widgets.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 24.0,
              // vertical: 32.0,
            ),
            color: Color(0xFFF6F6F6),
            child: Stack(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 32.0),
                  ),
                  Row(
                    children: [
                      Image(
                        image: AssetImage('assets/images/logo.png'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 35,
                        ),
                        child: Text(
                          "Hello !",
                          style: TextStyle(
                            color: Color(0xFF211551),
                            fontSize: 22.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getTasks(),
                      builder: (context, snapshot) {
                        var scrollConfiguration;
                        if (snapshot.data.length > 0) {
                          scrollConfiguration = ScrollConfiguration(
                            behavior: NoGlowBehaviour(),
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                print("okok : ${snapshot.data.length}");
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Taskpage(
                                                task: snapshot.data[index],
                                              )),
                                    ).then((value) {
                                      setState(() {});
                                    });
                                  },
                                  child: TaskCardWidget(
                                    title: snapshot.data[index].title,
                                    desc: snapshot.data[index].description,
                                  ),
                                );
                              },
                            ),
                          );
                          return scrollConfiguration;
                        } else {
                          scrollConfiguration = Center(
                              child: Container(
                            child: Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.all(40),
                                   
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Todo App is softwar in the category of Task Management, Projet Management,Productivity ",
                                        style: TextStyle(
                                          color: Color(0xFF6B6969),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    )),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Taskpage(
                                                task: null,
                                              )),
                                    ).then((value) {
                                      setState(() {});
                                    });
                                    print("create new task");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF7349FE),
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: Color(0xFF430CF5),
                                        width: 4,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Text(
                                        "Create New Task",
                                        style: TextStyle(
                                          color: Color(0xFFFDFDFD),
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ));
                        }
                        return scrollConfiguration;
                      },
                    ),
                  ),
                ]),
                Positioned(
                  bottom: 32.0,
                  right: 0.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Taskpage(
                                  task: null,
                                )),
                      ).then((value) {
                        setState(() {});
                      });
                    },
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF7349FE), Color(0xFF3900F5)],
                          begin: Alignment(0, -1),
                          end: Alignment(0, 1),
                        ),
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      child: Image(
                          image: AssetImage(
                        "assets/images/add_icon.png",
                      )),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
