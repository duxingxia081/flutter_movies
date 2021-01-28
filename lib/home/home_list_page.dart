import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/app/app_color.dart';
import 'package:flutter_movies/app/movie_api.dart';
import 'package:flutter_movies/home/movie_grid_page.dart';
import 'package:flutter_movies/model/movie_detail.dart';
import 'package:flutter_movies/utils/data_to_list.dart';

import 'home_slider_widget.dart';

class HomeListPage extends StatefulWidget {
  @override
  _HomeListPageState createState() => _HomeListPageState();
}

class _HomeListPageState extends State<HomeListPage>
    with AutomaticKeepAliveClientMixin {
  List<MovieDetail> slidersList;
  List<MovieDetail> dianyingList;
  List<MovieDetail> dianshiList;
  List<MovieDetail> zongyiList;
  List<MovieDetail> dongmansList;

  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    if (slidersList == null) {
      return new Center(
        child: new CupertinoActivityIndicator(),
      );
    } else {
      return Container(
        color: AppColor.primary,
        child: ListView(
          addAutomaticKeepAlives: true,
          children: [
            HomeSliderWidget(slidersList),
            MovieGridPage(
              typeId: 1,
              typeName: '电影',
              movies: dianyingList,
            ),
            MovieGridPage(
              typeId: 2,
              typeName: '电视剧',
              movies: dianshiList,
            ),
            MovieGridPage(
              typeId: 3,
              typeName: '综艺',
              movies: zongyiList,
            ),
            MovieGridPage(
              typeId: 4,
              typeName: '动漫',
              movies: dongmansList,
            )
          ],
        ),
      );
    }
  }

  // 加载数据
  Future<void> fetchData() async {
    MovieApi api = MovieApi();
    var sliders = await api.getHomeSliders(); //获取推荐值为9的电影数据5条数据
    var hitsMonthDianying = await api.getHomeGridMoviesBypt(1); //电影
    var hitsMonthDianshi = await api.getHomeGridMoviesBypt(2);
    var hitsMonthZongyi = await api.getHomeGridMoviesBypt(3);
    var hitsMonthDongman = await api.getHomeGridMoviesBypt(4);
    slidersList = DataToList.movies2List(sliders);
    dianyingList = DataToList.movies2List(hitsMonthDianying);
    dianshiList = DataToList.movies2List(hitsMonthDianshi);
    zongyiList = DataToList.movies2List(hitsMonthZongyi);
    dongmansList = DataToList.movies2List(hitsMonthDongman);
  }

  @override
  bool get wantKeepAlive => true;
}
