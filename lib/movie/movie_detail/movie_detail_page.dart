import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/app/app_color.dart';
import 'package:flutter_movies/model/movie_detail.dart';
import 'package:flutter_movies/movie/movie_detail/movie_detail_head.dart';
import 'package:flutter_movies/movie/movie_detail/movie_detail_play_list.dart';

class MovieDetailPage extends StatefulWidget {
  // 电影 id
  final MovieDetail movie;

  const MovieDetailPage({Key key, this.movie}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _controller;
  List<VodPlayList> vodPlayList = [];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 0, vsync: this);
    if (null != widget.movie.vodPlayList) {
      vodPlayList = widget.movie.vodPlayList.where((element) {
        return element.from != 'ckm2u8';
      }).toList();
    }
    _controller = TabController(length: vodPlayList.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.movie == null) {
      return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: GestureDetector(
              onTap: () => {Navigator.pop(context)},
              child: Image.asset('images/icon_arrow_back_black.png'),
            ),
          ),
          body: Center(
            child: CupertinoActivityIndicator(),
          ));
    }
    return Scaffold(
        appBar: AppBar(title: Text(widget.movie.vodName)),
        body: Container(
          color: AppColor.darkGrey,
          child: ListView(
            children: [
              MovieDetailHead(
                movie: widget.movie,
              ),
              MovieDetailPlayList(
                vodPlayList: vodPlayList,
                controller: _controller,
              ),
            ],
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
