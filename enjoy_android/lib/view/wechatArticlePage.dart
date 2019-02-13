import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class WechatArticlePage extends StatefulWidget {
  @override
  WechatArticleState createState() => new WechatArticleState();
}

class WechatArticleState extends State<WechatArticlePage> {
  @override
  Widget build(BuildContext context) {

    getWeChatArticle();

    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("公众号"),
          backgroundColor: Color.fromARGB(255, 119, 136, 213), //设置appbar背景颜色
          centerTitle: true, //设置标题是否局中
        ),
        body: new Center(
          child: new Text('微信公众号'),
        ),
      ),
    );
  }
  
  void getWeChatArticle() async {
    try {
      Response response;
      response = await Dio().get("http://wanandroid.com/wxarticle/chapters/json");
      return print(response);
    } catch (e) {
      return print(e);
    }
  }
}