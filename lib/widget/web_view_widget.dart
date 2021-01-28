import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_movies/utils/data_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  final String title;
  final String url;

  const WebViewWidget({Key key, this.title, this.url}) : super(key: key);

  @override
  _WebViewWidgetState createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    var banUrls = ['youku', 'sohu', 'mgtv', 'iqiyi', 'itm', 'letvclient'];
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        // We're using a Builder here so we have a context that is below the Scaffold
        // to allow calling Scaffold.of(context) so we can show a snackbar.
        body: Builder(builder: (BuildContext context) {
          return WebView(
            initialUrl: DataUtils.httpToHttps(widget.url),
            javascriptMode: JavascriptMode.unrestricted,
            navigationDelegate: (NavigationRequest request) {
              //路由委托（可以通过在此处拦截url实现JS调用Flutter部分）
              for (final value in banUrls) {
                if (request.url?.startsWith(value) ?? false) {
                  return NavigationDecision.prevent;
                  ///阻止路由替换，不能跳转，因为这是js交互给我们发送的消息
                }
              }
              return NavigationDecision.navigate;
              ///允许路由替换
            },
          );
        }));
  }
}
