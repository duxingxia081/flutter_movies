import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/app/app_navigator.dart';
import 'package:flutter_movies/app/movie_api.dart';
import 'package:flutter_movies/model/movie_detail.dart';
import 'package:flutter_movies/utils/data_to_list.dart';
import 'package:flutter_movies/utils/data_utils.dart';
import 'package:flutter_movies/utils/screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const PAGE_SIZE = 10;

class MovieCategoryPage extends StatefulWidget {
  final int t;

  const MovieCategoryPage({Key key, this.t}) : super(key: key);

  @override
  _MovieCategoryPageState createState() => _MovieCategoryPageState();
}

class _MovieCategoryPageState extends State<MovieCategoryPage>
    with AutomaticKeepAliveClientMixin {
  int pageIndex = 1;
  List<MovieDetail> movieList = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void initState() {
    super.initState();
    _fetchData(loadMore: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullUp: true,
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("上拉加载");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("加载失败！点击重试！");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("加载更多!");
            } else {
              body = Text("没有更多数据了!");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onLoading: _fetchData,
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: movieList?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return _MovieItem(movie: movieList[index]);
          },
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
        ),
      ),
    );
  }

  void _fetchData({loadMore = true}) async {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }
    MovieApi api = MovieApi();
    Future movies = await api.getMoviesByCategory(
        t: widget.t, pg: pageIndex, pagesize: PAGE_SIZE, order: 'vod_level');
    List<MovieDetail> movieDetailList = DataToList.movies2List(movies);
    setState(() {
      movieList.addAll(movieDetailList);
    });
    _refreshController.loadComplete();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _MovieItem extends StatelessWidget {
  final MovieDetail movie;
  final double width = (Screen.width - 10) / 2;
  final double height =
      (Screen.height - Screen.bottomSafeHeight - Screen.bottomSafeHeight) / 3;

  _MovieItem({Key key, this.movie}) : super(key: key);

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppNavigator.pushMovieDetail(context, movie);
      },
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            children: [
              Center(child: _itemImage()),
              Center(
                child: Text(
                  movie.vodName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _itemImage() {
    return Stack(
      children: [
        Hero(
            tag: '${movie.vodId}',
            child: Container(
              width: width,
              height: height,
              child: CachedNetworkImage(
                imageUrl: DataUtils.httpToHttps(movie.vodPic),
                fit: BoxFit.cover,
                errorWidget: (context, url, d) => Image.asset(
                  "images/icon_nothing.png",
                  fit: BoxFit.cover,
                ),
              ),
            ))
      ],
    );
  }
}
