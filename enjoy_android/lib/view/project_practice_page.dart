import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:enjoy_android/model/project_classify_bean.dart';
import 'package:enjoy_android/widget/async_snapshot_widget.dart';
import 'package:enjoy_android/view/project_list_page.dart';

/// 项目实践页
class ProjectPracticePage extends StatefulWidget {
  @override
  _ProjectPracticeState createState() => _ProjectPracticeState();
}

class _ProjectPracticeState extends State<ProjectPracticePage> with SingleTickerProviderStateMixin {
  TabController _tabCtrl;
  var _tabsName = List<String>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: _buildFuture, future: getProjectClassify());
  }

  Widget _buildFuture(BuildContext context, AsyncSnapshot<List<ProjectClassify>> snapshot) {
    return AsyncSnapshotWidget(
      snapshot: snapshot,
      successWidget: (snapshot) {
        if(snapshot.data != null){
          _parseWeChatCounts(snapshot.data);
          if(_tabCtrl == null){
            _tabCtrl = TabController(length: snapshot.data.length, vsync: this, initialIndex: 0);
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("项目"),
              backgroundColor: Color.fromARGB(255, 119, 136, 213), //设置appbar背景颜色
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

  /// 网络请求，获取项目分类
  Future<List<ProjectClassify>> getProjectClassify() async {
    try {
      Response response;
      response = await Dio().get("http://www.wanandroid.com/project/tree/json");
      return ProjectClassifyBean.fromJson(response.data).data;
    } catch (e) {
      return null;
    }
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

  /// 创建项目列表页
  List<Widget> _createPages(List<ProjectClassify> projectClassify){
    List<Widget> widgets = List();
    for (ProjectClassify project in projectClassify) {
      var page = ProjectListPage(cid: project.id);
      widgets.add(page);
    }
    return widgets;
  }

  /// 解析微信公众号列表
  void _parseWeChatCounts(List<ProjectClassify> projectClassify){
    _tabsName.clear();
    for(ProjectClassify project in projectClassify){
      _tabsName.add(project.name);
    }
  }
}