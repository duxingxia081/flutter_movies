import 'package:dio/dio.dart';
import 'package:flutter_movies/utils/toast.dart';

class MovieApi {
  static const String baseUrl = 'https://www.jinrikanpian.net/appapi.php/';
  var dio = MovieApi.createDio();

  static Dio createDio() {
    var options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 100000,
/*      contentType: 'json',
        queryParameters: {
          //"apikey":apiKey
        }*/
    );
    return Dio(options);
  }

  ///首页幻灯片 指定leve=9 默认5条数据
  Future<dynamic> getHomeSliders({leve = 9, pagesize = 5}) async {
    return getMoviesByCategory(leve: leve, pagesize: pagesize);
  }
  ///首页网格按父类推荐视频
  ///指定leve=8 默认6条数据
  Future<dynamic> getHomeGridMoviesBypt(int pt,
      {leve = 8, pagesize = 6}) async {
    return getMoviesByCategory(pt: pt, leve: leve, pagesize: pagesize);
  }
  ///获取电影列表
  //pt 父类
  //t 类别id
  //pg=页码
  //wd=搜索关键字
  //h=几小时内的数据
  //pagesize一页展示多少条
  //leve指定推荐数1-9
  //order按照什么排列，比如vod_id是按照id排列,vod_time按照时间排列，vod_hits_month按照当月点击数排行
  //例如：/api/vod/?ac=detail&t=1&pg=5   分类ID为1的列表数据第5页
  //api按照更新时间
  Future<dynamic> getMoviesByCategory(
      {int pt,
      int t,
      int pg,
      String wd,
      int h,
      int pagesize,
      int leve,
      String order}) async {
    Response<Map> response;
    try {
      response = await dio.get('api/vod/?ac=detail', queryParameters: {
        'pt': pt,
        't': t,
        'pg': pg,
        'wd': wd,
        'h': h,
        'pagesize': pagesize,
        'leve': leve,
        'order': order
      });
    } catch (e) {
      Toast.show(e.toString());
      return null;
    }
    return response.data['list'];
  }
  ///指定父类，获取下面所有子类
  Future<dynamic> getSubcategoryByPcategory({int pt}) async {
    Response<Map> response;
    try {
      response = await dio.get('api/getSubcategoryByPcategory',
          queryParameters: {'pt': pt});
    } catch (e) {
      Toast.show('网络异常');
      return null;
    }
    return response.data['list'];
  }
}
