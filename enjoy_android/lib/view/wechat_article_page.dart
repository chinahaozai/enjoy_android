import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class WechatArticlePage extends StatefulWidget {
  @override
  WechatArticleState createState() => new WechatArticleState();
}

class WechatArticleState extends State<WechatArticlePage> with SingleTickerProviderStateMixin{
  TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(
        length:4, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {

    getWeChatArticle();
    return Scaffold(
      appBar: AppBar(
        title: Text("公众号"),
        backgroundColor: Color.fromARGB(255, 119, 136, 213), //设置appbar背景颜色
        centerTitle: true, //设置标题是否局中
      ),
      body: Column(
        children: <Widget>[
          TabBar(
            indicatorColor: Colors.deepPurpleAccent,
            controller: _tabCtrl,
            isScrollable: true,
            tabs: [
              Tab(
                text: '大神',
              ),
              Tab(
                text: '小弟',
              ),
              Tab(
                text: '花花',
              ),
              Tab(
                text: '草草',
              ),
            ],
          )
        ],
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

  List<Widget> _parseTabs() {
    List<Widget> widgets = List();
    /*var children = widget.knowledge.children;
    for (KnowledgeSystem item in children) {
      var tab = Tab(
        text: item.name,
      );
      widgets.add(tab);
    }*/
    return widgets;
  }
}