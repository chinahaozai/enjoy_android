import 'package:flutter/material.dart';
import 'package:enjoy_android/model/wechat_article_bean.dart';
import 'package:enjoy_android/view/webview_page.dart';
import 'package:enjoy_android/manager/api_manager.dart';
import 'package:enjoy_android/widget/item_wechat_article.dart';

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

class _WechatArticleListState extends State<WechatArticleListPage> with SingleTickerProviderStateMixin {

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
        return WechatArticleItem(articles[position]);
      },
    );
  }

  /// 网络请求，获取微信文章列表
  void getList() async {
    await ApiManager().getWechatArticle(widget.cid, index)
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
