import 'package:flutter/material.dart';
import 'package:enjoy_android/model/wechat_article_bean.dart';
import 'package:dio/dio.dart';
import 'package:enjoy_android/view/webview_page.dart';

/// 项目列表页
class ProjectListPage extends StatefulWidget {
  int cid = 0;

  ProjectListPage({@required this.cid});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProjectListState();
  }
}

class _ProjectListState extends State<ProjectListPage> with AutomaticKeepAliveClientMixin {

  int index = 1;
  List<Article> articles = List();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //return ListView(children: getItems());
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (BuildContext context, int position){
        return getRow(articles[position]);
      },
    );
  }

  Widget getRow(Article article){
    return new GestureDetector(
      child: new Padding(
          padding: new EdgeInsets.all(15.0),
          child: new Text(article.title)),
      onTap: () {
        Navigator.push(context, new MaterialPageRoute(builder: (context)=> WebViewPage(title: article.title, url: article.link)));
      },
    );
  }

  void getList() async {
    await Dio().get("http://www.wanandroid.com/project/list/1/json", queryParameters: {"cid": widget.cid})
        .then((response){
          if(response != null){
            var wechatArticleBean = WechatArticleBean.fromJson(response.data);
            setState(() {
              articles.addAll(wechatArticleBean.data.datas);
            });
          }
    });
  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
