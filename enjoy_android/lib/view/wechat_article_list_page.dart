import 'package:flutter/material.dart';

/// 微信文章列表页
class WechatArticleListPage extends StatefulWidget {
  int cid = 0;

  WechatArticleListPage({@required this.cid});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WechatArticleListState(cid);
  }
}

class _WechatArticleListState extends State<WechatArticleListPage> with AutomaticKeepAliveClientMixin {
  int cid = 0;

  _WechatArticleListState(@required this.cid);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text('${cid}');

  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
