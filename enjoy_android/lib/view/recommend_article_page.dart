import 'package:flutter/material.dart';

/// 推荐文章页
class RecommendArticlePage extends StatefulWidget {
  @override
  RecommendArticlePageState createState() => new RecommendArticlePageState();
}

class RecommendArticlePageState extends State<RecommendArticlePage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("推荐文章"),
          backgroundColor: Color.fromARGB(255, 119, 136, 213), //设置appbar背景颜色
          centerTitle: true, //设置标题是否局中
        ),
        body: new Center(
          child: new Text('推荐文章'),
        ),
      ),
    );
  }
}