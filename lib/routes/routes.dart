import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/pages/about_page.dart';
import 'package:flutter_coding_thailand/pages/contact_page.dart';
import 'package:flutter_coding_thailand/pages/detail_page.dart';
import 'package:flutter_coding_thailand/pages/home_page.dart';
import 'package:flutter_coding_thailand/pages/product_page.dart';

class Routes {
  static const home = '/';
  static const contact = '/contact';
  static const about = '/about';
  static const detail = '/detail';
  static const products = '/products';

  static final Map<String, WidgetBuilder> _route = {
    home: (BuildContext context) => HomePage(),
    contact: (contact) => ContactPage(),
    about: (context) => AboutPage(),
    detail: (context) => DetailPage(),
    products: (context) => ProductPage(),
  };
  static Map<String, WidgetBuilder> getPage() => _route;
}
