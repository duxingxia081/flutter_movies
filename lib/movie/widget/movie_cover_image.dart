import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/model/movie_detail.dart';
import 'package:flutter_movies/utils/data_utils.dart';

class MovieCoverImage extends StatelessWidget {
  final double width;
  final double height;
  final MovieDetail movie;

  const MovieCoverImage({Key key, this.width, this.height, this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        child: Hero(
          tag: '${movie.vodId}',
          child: CachedNetworkImage(
              imageUrl: DataUtils.httpToHttps(movie.vodPic),
              fit: BoxFit.cover,
              width: width,
              height: height,
              errorWidget: (context, url, d) => Image.asset(
                    "images/icon_nothing.png",
                    width: width,
                    height: height,
                    fit: BoxFit.cover,
                  )),
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}
