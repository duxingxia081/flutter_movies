import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/model/movie_detail.dart';

class MovieDetailCoverImage extends StatelessWidget {
  final String imgUrl;
  final double width;
  final double height;
  final MovieDetail movie;

  MovieDetailCoverImage(this.imgUrl, {this.width, this.height, this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        child: Hero(
          tag: '${movie.vodId}',
          child: CachedNetworkImage(
            imageUrl: imgUrl,
            fit: BoxFit.cover,
            width: width,
            height: height,
            errorWidget: (context, url, d) => Image.asset(
              "images/icon_nothing.png",
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
          ),
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}
