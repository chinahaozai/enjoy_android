import 'package:flutter/material.dart';
import 'package:enjoy_android/model/home_article_bean.dart';
import 'package:enjoy_android/view/webview_page.dart';
import 'package:enjoy_android/constant/textsize_const.dart';

/// 首页文章列表条目
class HomeArticleItem extends StatefulWidget {
  Article article;
  HomeArticleItem(this.article);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeArticleState();
  }
}

class _HomeArticleState extends State<HomeArticleItem> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (ctx) => WebViewPage(
                    title: widget.article.title, url: widget.article.link)));
      },
      child: Card(
          margin: EdgeInsets.fromLTRB(2,5,2,0),
          child: Container(
            padding: EdgeInsets.fromLTRB(18,10,18,10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.device_hub,
                      color: Colors.blueAccent,
                      size: 15,
                    ),
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            widget.article.author,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ))
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      widget.article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: TextSizeConst.middleTextSize),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      color: Colors.grey,
                      size: 15,
                    ),
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            widget.article.niceDate,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ))
                  ],
                )
              ],
            ),
          )),
    );
  }
}
