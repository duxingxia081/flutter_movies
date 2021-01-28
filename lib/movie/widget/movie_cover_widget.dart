import 'package:flutter/material.dart';
import 'package:flutter_movies/app/app_color.dart';
import 'package:flutter_movies/app/app_navigator.dart';
import 'package:flutter_movies/model/movie_detail.dart';
import 'package:flutter_movies/movie/widget/movie_cover_image.dart';
import 'package:flutter_movies/utils/screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieCoverWidget extends StatelessWidget {
  final MovieDetail movie;
  final int num; //一行放的电影数
  const MovieCoverWidget({Key key, this.num, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = (Screen.width - 60) / num;
    return Container(
      child: InkWell(
        onTap: () => AppNavigator.pushMovieDetail(context, movie),
        child: Container(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MovieCoverImage(
                width: width,
                height: width / 0.75,
                movie: movie,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${movie.vodName}',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Expanded(child: RatingBarIndicator(
                    rating: double.parse(movie.vodScore) / 2,
                    itemCount: 5,
                    itemSize: 18,
                    itemBuilder: (context, index) =>
                        Icon(
                          Icons.star,
                          color: AppColor.orange,
                        ),
                  ),),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    movie.vodScore,
                    style: TextStyle(fontSize: 12),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
