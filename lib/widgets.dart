import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  final String title;
  final String desc;
  TaskCardWidget({this.title, this.desc});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 24.0
      ),
      margin: EdgeInsets.only(
        bottom: 20.0
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0)

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? ("New Task "),
            style: TextStyle(
              color: Color(0xFF211551),
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top:20.0,
            ),
            child: Text(
              desc ?? ("No description"),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
                height: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      )
    );
  }
}


class TodoWidget extends StatelessWidget {
  final String text;
  final bool isDone;
  TodoWidget({this.text,@required this.isDone});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 8,
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            margin: EdgeInsets.only(
              right:16,
            ),
            decoration: BoxDecoration(
              color: isDone ? Color(0xFF7349FE) : Colors.transparent ,
              borderRadius: BorderRadius.circular(5),
              border: isDone ? null : Border.all(
                color: Colors.grey,
                width: 1.5,
              ),
            ),
            child: Image(image: AssetImage(
              'assets/images/check_icon.png'
            ),
            ),
          ),
          Text(
            text ?? ("Todo Widget"),
            style: TextStyle(
              color: isDone ? Color(0xFF211551) : Colors.grey ,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      
    );
  }
}

class NoGlowBehaviour extends ScrollBehavior {
  @override 

    Widget buildViewportChrome (BuildContext context, Widget child, AxisDirection axisDirection){
      return child;
    }
  
}