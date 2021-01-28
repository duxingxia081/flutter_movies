import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/app/app_color.dart';
import 'package:flutter_movies/model/movie_detail.dart';
import 'package:flutter_movies/movie/movie_detail/movie_detail_cover_image.dart';
import 'package:flutter_movies/utils/data_utils.dart';
import 'package:flutter_movies/utils/screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetailHead extends StatelessWidget {
  final MovieDetail movie;

  MovieDetailHead({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = Screen.width;
    var height = 218.0 + Screen.topSafeHeight;
    var pic = movie.vodPic.replaceFirst(RegExp("http"), "https");
    return Container(
      height: height,
      width: width,
      child: Stack(
        children: [
          Image(
            image: CachedNetworkImageProvider(pic),
            fit: BoxFit.cover,
            width: width,
            height: height,
          ),
          Opacity(
            opacity: 0.7,
            child: Container(
                color: AppColor.darkGrey, width: width, height: height),
          ),
          buildContent(context)
        ],
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    var width = Screen.width;
    var height = 218.0 + Screen.topSafeHeight;
    var pic = DataUtils.httpToHttps(movie.vodPic);
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.fromLTRB(15, 54 + Screen.topSafeHeight, 10, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: MovieDetailCoverImage(pic,
                width: 100, height: 133, movie: movie),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.vodName,
                style: TextStyle(
                    color: AppColor.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  RatingBarIndicator(
                    rating: double.parse(movie.vodScore) / 2,
                    itemCount: 5,
                    itemSize: 24,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: AppColor.orange,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    movie.vodScore,
                    style: TextStyle(color: AppColor.white, fontSize: 12),
                  )
                ],
              ),
              Text(
                '${movie.vodArea}/${movie.vodClass} 上映时间:${movie.vodYear} 演员:${movie.vodActor}',
                style: TextStyle(color: AppColor.white, fontSize: 12),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ))
        ],
      ),
    );
  }
}
