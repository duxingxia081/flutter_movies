import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/app/app_color.dart';
import 'package:flutter_movies/app/app_navigator.dart';
import 'package:flutter_movies/model/movie_detail.dart';
import 'package:flutter_movies/utils/screen.dart';
import 'package:flutter_movies/widget/web_view_widget.dart';

class MovieDetailPlayList extends StatelessWidget {
  final List<VodPlayList> vodPlayList;
  final TabController controller;

  const MovieDetailPlayList({Key key, this.vodPlayList, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (vodPlayList == null || vodPlayList.length == 0) {
      return Container(
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        child: Text(
          '',
          style: TextStyle(fontSize: 18, color: AppColor.red),
        ),
      );
    } else {
      double height;
      if (vodPlayList[0].urls.length % 4 == 0) {
        height = ((vodPlayList[0].urls.length ~/ 4) *
            ((Screen.width - 30) / 8 + 10));
      } else {
        height = (vodPlayList[0].urls.length ~/ 4 + 1) *
            ((Screen.width - 30) / 8 + 10);
      }
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
                controller: controller,
                isScrollable: true,
                labelColor: Colors.white,
                tabs: vodPlayList.map((tab) {
                  return Tab(
                    child: Text(tab.playerInfo.show),
                  );
                }).toList()),
            Container(
              height: height,
              child: TabBarView(
                  dragStartBehavior: DragStartBehavior.down,
                  physics: NeverScrollableScrollPhysics(), //禁止滑动
                  controller: controller,
                  children: vodPlayList.map((tab) {
                    return GridView.count(
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      crossAxisCount: 4,
                      childAspectRatio: 2,
                      children: _builderUrl(context, tab.urls),
                    );
                  }).toList()),
            ),
          ],
        ),
      );
    }
  }

  _builderUrl(BuildContext context, List<Urls> urls) {
    // ignore: missing_return
    return urls.map((url) {
      return InkWell(
        onTap: () {
          AppNavigator.push(
              context,
              WebViewWidget(
                title: url.name,
                url: url.url,
              ));
        },
        child: Container(
          //height: 15,
          alignment: Alignment.center,
          child: Text(
            url.name.replaceAll('-', '').replaceAll('期', ''),
            style: TextStyle(color: AppColor.white, fontSize: 15),
            maxLines: 1,
          ),
          color: AppColor.grey,
        ),
      );
    }).toList();
  }
}
