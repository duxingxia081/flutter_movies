import 'package:flutter/material.dart';
import 'package:flutter_movies/app/movie_api.dart';
import 'package:flutter_movies/category/movie_category_page.dart';
import 'package:flutter_movies/model/movie_category_detail.dart';
import 'package:flutter_movies/utils/data_to_list.dart';
import 'package:flutter_movies/widget/web_view_widget.dart';

class MovieCategoryTabPage extends StatefulWidget {
  final int pt;

  const MovieCategoryTabPage({Key key, this.pt}) : super(key: key);

  @override
  _MovieCategoryTabPageState createState() => _MovieCategoryTabPageState();
}

class _MovieCategoryTabPageState extends State<MovieCategoryTabPage>
    with TickerProviderStateMixin {
  TabController _controller;
  List<MovieCategoryDetail> tabs = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    _controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('影视分类'),
          bottom: TabBar(
            controller: _controller,
            isScrollable: true,
            tabs: tabs
                .map((tab) => Tab(
                      child: Text(tab.typeName),
                    ))
                .toList(),
          )),
      body: TabBarView(
        controller: _controller,
        children: tabs
            .map((e) => MovieCategoryPage(
                  t: e.typeId,
                ))
            .toList(),
      ),
    );
  }

  // 加载数据
  Future<void> fetchData() async {
    MovieApi api = MovieApi();
    var types =
        await api.getSubcategoryByPcategory(pt: widget.pt).catchError((e) {
      print(e.toString());
    });
    if (types != null && mounted) {
      setState(() {
        tabs = DataToList.types2List(types);
        _controller = TabController(length: tabs.length, vsync: this);
      });
    }
  }
}
