import 'package:flutter/material.dart';
import 'package:flutter_movies/app/app_navigator.dart';
import 'package:flutter_movies/category/movie_category_tab_page.dart';

class HomeSectionPage extends StatelessWidget {
  final int typeId; //分类ID
  final String typeName; //分类名称
  const HomeSectionPage({Key key, this.typeId, this.typeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${typeName}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {
              AppNavigator.push(context, MovieCategoryTabPage(pt: typeId));
            },
            child: Row(
              children: [
                Text(
                  '更多...',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
