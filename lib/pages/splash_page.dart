import 'package:flutter/material.dart';
import 'package:flutter_movies/navigator/tab_navigator.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(child: TabNavigator(),);
  }
}
