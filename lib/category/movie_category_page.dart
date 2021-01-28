import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/app/app_navigator.dart';
import 'package:flutter_movies/app/movie_api.dart';
import 'package:flutter_movies/model/movie_detail.dart';
import 'package:flutter_movies/utils/data_to_list.dart';
import 'package:flutter_movies/utils/data_utils.dart';
import 'package:flutter_movies/utils/screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
  ScrollController _scrollController = ScrollController();

  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchData(loadMore: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _fetchData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text("loading..."),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text("error"),
            );
          } else if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data.length > 0) {
            List<MovieDetail> movieDetailMacsList =
                DataToList.movies2List(snapshot.data);
            return StaggeredGridView.countBuilder(
              controller: _scrollController,
              crossAxisCount: 4,
              itemCount: movieDetailMacsList?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return _MovieItem(movie: movieDetailMacsList[index]);
              },
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
            );
          } else {
            return Center(
              child: Text("error"),
            );
          }
        }
        return Center(
          child: Text("error"),
        );
      },
    ));
  }

  Future _fetchData({loadMore = false}) async {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }
    MovieApi api = MovieApi();
    Future movies = api.getMoviesByCategory(
        t: widget.t, pg: pageIndex, pagesize: PAGE_SIZE, order: 'vod_level');
    return movies;
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
