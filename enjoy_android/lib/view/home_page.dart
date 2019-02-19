import 'package:dio/dio.dart';
import 'package:enjoy_android/constant/color_const.dart';
import 'package:enjoy_android/constant/textsize_const.dart';
import 'package:enjoy_android/manager/api_manager.dart';
import 'package:enjoy_android/model/home_article_bean.dart';
import 'package:enjoy_android/model/home_banner_bean.dart';
import 'package:enjoy_android/widget/item_home_article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

/// 首页
class HomePage extends StatefulWidget {

  /*BuildContext mainContext;
  HomePage(this.mainContext);*/

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  // 首页banner列表
  List<HomeBanner> banners = List();

  // 首页文章列表
  List<Article> articles = List();

  SwiperController _controller = SwiperController();

  //  请求首页文章页码
  int index = 0;

  @override
  void initState() {
    super.initState();
    getBanner();
    getList();
    _controller.autoplay = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("推荐文章"),
          backgroundColor: Color.fromARGB(255, 119, 136, 213), //设置appbar背景颜色
          centerTitle: true, //设置标题是否局中
        ),
        body: ListView.builder(
            itemCount: articles.length + 1,
            itemBuilder: (context, index) {
              return index == 0
                  ? createBannerItem()
                  : HomeArticleItem(articles[index - 1]);
            }),
    );
  }

  /// 创建banner条目
  Widget createBannerItem(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: banners.length != 0
          ? Swiper(
        autoplayDelay: 3500,
        controller: _controller,
        itemWidth: MediaQuery.of(context).size.width,
        itemHeight: 180,
        pagination: pagination(),
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            banners[index].imagePath,
            fit: BoxFit.fill,
          );
        },
        itemCount: banners.length,
        viewportFraction: 0.8,
        scale: 0.9,
      )
          : SizedBox(
        width: 0,
        height: 0,
      ),
    );
  }

  SwiperPagination pagination() => SwiperPagination(
      margin: EdgeInsets.all(0.0),
      builder: SwiperCustomPagination(
          builder: (BuildContext context, SwiperPluginConfig config) {
        return Container(
          color: Colors.black45,
          height: 40,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            children: <Widget>[
              Text(
                "${banners[config.activeIndex].title}",
                style: TextStyle(
                    fontSize: TextSizeConst.smallTextSize,
                    color: Colors.white),
              ),
              Expanded(
                flex: 1,
                child: new Align(
                  alignment: Alignment.centerRight,
                  child: new DotSwiperPaginationBuilder(
                          color: Colors.white70,
                          activeColor: ColorConst.color_primary,
                          size: 6.0,
                          activeSize: 6.0)
                      .build(context, config),
                ),
              )
            ],
          ),
        );
      }));

  /// 获取首页banner数据
  void getBanner() async {
    Response response = await ApiManager().getHomeBanner();
    var homeBannerBean = HomeBannerBean.fromJson(response.data);
    setState(() {
      banners.clear();
      banners.addAll(homeBannerBean.data);
    });
  }

  /// 获取首页推荐文章数据
  void getList() async {
    Response response = await ApiManager().getHomeArticle(index);
    var homeArticleBean = HomeArticleBean.fromJson(response.data);
    setState(() {
      articles.clear();
      articles.addAll(homeArticleBean.data.datas);
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
