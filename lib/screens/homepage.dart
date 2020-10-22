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
                    margin: EdgeInsets.only(top: 32.0, bottom: 32.0),
                  ),
                  Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getTasks(),
                      builder: (context, snapshot) {
                        return ScrollConfiguration(
                          behavior: NoGlowBehaviour(),
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Taskpage(
                                              task: snapshot.data[index],
                                            )),
                                  ).then((value) {
                                    setState(() {
                                      
                                    });
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
