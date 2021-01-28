import 'package:flutter/material.dart';
import 'package:flutter_movies/app/app_color.dart';
import 'package:flutter_movies/home/home_section_page.dart';
import 'package:flutter_movies/model/movie_detail.dart';
import 'package:flutter_movies/movie/widget/movie_cover_widget.dart';

class MovieGridPage extends StatelessWidget {
  final List<MovieDetail> movies;
  final String typeName; //分类名称
  final int typeId;

  MovieGridPage({Key key, this.movies, this.typeName, this.typeId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      child: Column(
        children: [
          HomeSectionPage(
            typeId: typeId,
            typeName: typeName,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Center(
              child: Wrap(
                spacing: 15,
                runSpacing: 20,
                children: movies
                    .map((movie) => MovieCoverWidget(
                          movie: movie,
                          num: 2,
                        ))
                    .toList(),
              ),
            ),
          ),
          Container(
            height: 10,
            color: Color(0xFFF5F5F5),
          )
        ],
      ),
    );
  }
}
