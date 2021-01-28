import 'package:flutter_movies/model/movie_category_detail.dart';
import 'package:flutter_movies/model/movie_detail.dart';
//movies转换为List
class DataToList{
  static List<MovieDetail> movies2List(sliders) {
    List<MovieDetail> moviesList =[];
    sliders.forEach((data){
      moviesList.add(MovieDetail.fromJson(data));
    });
    return moviesList;
  }
  static List<MovieCategoryDetail> types2List(types) {
    List<MovieCategoryDetail> typesList=[];
    types.forEach((data){
      typesList.add(MovieCategoryDetail.fromJson(data));
    });
    return typesList;
  }

}