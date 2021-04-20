import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/pages/news/news_page.dart';
import 'package:flutter_coding_thailand/pages/news/web_view_page.dart';
import 'package:flutter_coding_thailand/routes/routes.dart';

class NewsStack extends StatefulWidget {
  @override
  _NewsStackState createState() => _NewsStackState();
}

class _NewsStackState extends State<NewsStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: Routes.news,
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case Routes.news:
            builder = (BuildContext _) => NewsPage();
            break;
          case Routes.webview:
            builder = (BuildContext _) => WebViewPage();
            break;

          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
