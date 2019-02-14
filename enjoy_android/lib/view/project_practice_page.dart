import 'package:flutter/material.dart';

class ProjectPracticePage extends StatefulWidget {
  @override
  ProjectPracticeState createState() => new ProjectPracticeState();
}

class ProjectPracticeState extends State<ProjectPracticePage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("项目实践"),
          backgroundColor: Color.fromARGB(255, 119, 136, 213), //设置appbar背景颜色
          centerTitle: true, //设置标题是否局中
        ),
        body: new Center(
          child: new Text('项目实践'),
        ),
      ),
    );
  }
}