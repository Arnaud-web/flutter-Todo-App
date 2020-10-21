import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea (
        child: Container(
          padding: EdgeInsets.all(24.0),
          child : Column(
            children: [
              Image(
                image: AssetImage(
                'assets/images/logo.png'
              ),
              ),
            ]
          )
        ),
      ),
    );
  }
}