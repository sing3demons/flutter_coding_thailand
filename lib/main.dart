import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/pages/news/stack/news_stack.dart';
import 'package:flutter_coding_thailand/pages/product/stack/product_stack.dart';
import 'package:flutter_coding_thailand/pages/home/stack/home_stack.dart';
import 'package:flutter_coding_thailand/routes/routes.dart';
import 'package:flutter_coding_thailand/pages/users/stack/users_stack.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: {
      Routes.root: (BuildContext context) => HomeStack(),
      Routes.productstack: (context) => ProductStack(),
      Routes.usersStack: (context) => UsersStack(),
      Routes.newsstack: (context) => NewsStack(),
    });
  }
}
