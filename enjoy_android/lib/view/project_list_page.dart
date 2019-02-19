import 'package:enjoy_android/manager/api_manager.dart';
import 'package:enjoy_android/model/project_list_bean.dart';
import 'package:enjoy_android/view/webview_page.dart';
import 'package:flutter/material.dart';

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
  List<Project> projects = List();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (BuildContext context, int position){
        return getRow(projects[position]);
      },
    );
  }

  Widget getRow(Project project){
    return new GestureDetector(
      child: new Padding(
          padding: new EdgeInsets.all(15.0),
          child: new Text(project.title)),
      onTap: () {
        Navigator.push(context, new MaterialPageRoute(builder: (context)=> WebViewPage(title: project.title, url: project.link)));
      },
    );
  }

  /// 获取项目列表
  void getList() async {
    await ApiManager().getProjectList(widget.cid, index)
        .then((response){
          if(response != null){
            var projectListBean = ProjectListBean.fromJson(response.data);
            setState(() {
              projects.addAll(projectListBean.data.datas);
            });
          }
    });
  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
