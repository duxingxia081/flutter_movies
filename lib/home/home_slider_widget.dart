import 'package:flutter/material.dart';
import 'package:flutter_movies/app/app_navigator.dart';
import 'package:flutter_movies/model/movie_detail.dart';
import 'package:flutter_movies/utils/data_utils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeSliderWidget extends StatelessWidget {
  List<MovieDetail> moviesDetails;

  HomeSliderWidget(this.moviesDetails);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          MovieDetail movie = moviesDetails[index];
          var pic = DataUtils.httpToHttps(movie.vodPic);
          return (Image.network(
            pic,
            fit: BoxFit.fill,
          ));
          //return Container(child: Center(child: Text(movie.vodPic),),);
        },
        onTap: (index) =>
            {AppNavigator.pushMovieDetail(context, moviesDetails[index])},
        itemCount: moviesDetails.length,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
      ),
    );
  }
}
