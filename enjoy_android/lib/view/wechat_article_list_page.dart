import 'package:flutter/material.dart';
import 'package:enjoy_android/model/wechat_article_bean.dart';
import 'package:dio/dio.dart';
import 'package:enjoy_android/view/webview_page.dart';

/// 微信文章列表页
class WechatArticleListPage extends StatefulWidget {
  int cid = 0;

  WechatArticleListPage({@required this.cid});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WechatArticleListState();
  }
}

class _WechatArticleListState extends State<WechatArticleListPage> with AutomaticKeepAliveClientMixin {

  int index = 1;
  List<Datas> articles = List();


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

  List<Widget> getItems(){
    List<Widget> items = List();
    if(articles.length == 0) {
      items.add(new Padding(padding: new EdgeInsets.all(20.0), child: new Text('${widget.cid}')));
    } else {
      for(Datas datas in articles) {
        items.add(new Padding(padding: new EdgeInsets.all(20.0), child: new Text(datas.title)));
      }
    }

    return items;
  }

  Widget getRow(Datas data){
    return new GestureDetector(
      child: new Padding(
          padding: new EdgeInsets.all(15.0),
          child: new Text(data.title)),
      onTap: () {
        Navigator.push(context, new MaterialPageRoute(builder: (context)=> WebViewPage(title: data.title, url: data.link)));
      },
    );
  }

  void getList() async {
    await Dio().get("http://wanandroid.com/wxarticle/list/${widget.cid}/1/json")
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
