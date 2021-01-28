import 'package:flutter/material.dart';
import 'package:flutter_movies/home/home_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => {},
          )
        ],
      ),
      body: Center(
        child: HomeListPage(),
      ),
    );
  }
}
