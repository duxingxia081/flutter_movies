
import 'package:flutter/material.dart';
import 'package:flutter_movies/model/movie_detail.dart';
import 'package:flutter_movies/movie/movie_detail/movie_detail_page.dart';

class AppNavigator {
  static push(BuildContext context, Widget scene) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
  }

  // 进入电影详情
  static pushMovieDetail(BuildContext context, MovieDetail movie) {
//    AppNavigator.push(context, MovieDetailView(id: id));
    AppNavigator.push(context, MovieDetailPage(movie: movie));
  }
}