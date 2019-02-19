import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:enjoy_android/model/wechat_count_bean.dart';
import 'package:enjoy_android/widget/async_snapshot_widget.dart';
import 'package:enjoy_android/view/wechat_article_list_page.dart';
import 'package:enjoy_android/manager/api_manager.dart';

/// 微信公众号页
class WechatArticlePage extends StatefulWidget {
  @override
  WechatArticleState createState() => new WechatArticleState();
}

class WechatArticleState extends State<WechatArticlePage>
    with SingleTickerProviderStateMixin {
  TabController _tabCtrl;
  var _tabsName = List<String>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: _buildFuture, future: getWeChatCount());
  }

  Widget _buildFuture(
      BuildContext context, AsyncSnapshot<List<WechatCount>> snapshot) {
    return AsyncSnapshotWidget(
      snapshot: snapshot,
      successWidget: (snapshot) {
        if (snapshot.data != null) {
          _parseWeChatCounts(snapshot.data);
          if (_tabCtrl == null) {
            _tabCtrl = TabController(
                length: snapshot.data.length, vsync: this, initialIndex: 0);
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("公众号"),
              backgroundColor: Color.fromARGB(255, 119, 136, 213),
              //设置appbar背景颜色
              centerTitle: true, //设置标题是否局中
            ),
            body: Column(
              children: <Widget>[
                TabBar(
                  indicatorColor: Colors.deepPurpleAccent,
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.black45,
                  controller: _tabCtrl,
                  isScrollable: true,
                  tabs: _createTabs(),
                ),
                Expanded(
                  flex: 1,
                  child: TabBarView(
                      controller: _tabCtrl,
                      children: _createPages(snapshot.data)),
                )
              ],
            ),
          );
        }
      },
    );
  }

  /// 网络请求 获取推荐微信公众号
  Future<List<WechatCount>> getWeChatCount() async {
    Response response;
    await ApiManager().getWechatCount().then((res) {
      response = res;
    });
    return WechatCountBean.fromJson(response.data).data;
  }

  /// 生成顶部tab
  List<Widget> _createTabs() {
    List<Widget> widgets = List();
    for (String item in _tabsName) {
      var tab = Tab(
        text: item,
      );
      widgets.add(tab);
    }
    return widgets;
  }

  /// 创建微信文章列表页
  List<Widget> _createPages(List<WechatCount> list) {
    List<Widget> widgets = List();
    for (WechatCount count in list) {
      var page = WechatArticleListPage(cid: count.id);
      widgets.add(page);
    }
    return widgets;
  }

  /// 解析微信公众号列表
  void _parseWeChatCounts(List<WechatCount> wxCounts) {
    _tabsName.clear();
    for (WechatCount count in wxCounts) {
      _tabsName.add(count.name);
    }
  }
}
