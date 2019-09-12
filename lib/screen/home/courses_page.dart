import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
    CoursesPage({Key key}) :super(key : key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Icon(Icons.book,size: 80,color: Colors.black.withOpacity(.2),),),
    );
  }
}