import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/pages/home/about_page.dart';
import 'package:flutter_coding_thailand/pages/home/company_page.dart';
import 'package:flutter_coding_thailand/pages/home/contact_page.dart';
import 'package:flutter_coding_thailand/pages/home/covid_data.dart';
import 'package:flutter_coding_thailand/pages/home/room_page_v2.dart';
import 'package:flutter_coding_thailand/pages/product/detail_page_v2.dart';
import 'package:flutter_coding_thailand/pages/product/product_page_v2.dart';
import 'package:flutter_coding_thailand/pages/users/login_page.dart';
import 'package:flutter_coding_thailand/pages/home/home_page.dart';

class Routes {
  static const root = '/';
  static const home = 'homestack/home';
  static const contact = 'homestack/contact';
  static const about = 'homestack/about';
  static const company = 'homestack/company';
  static const covid = 'homestack/covid';
  static const room = 'homestack/room';

  static const newsstack = '/newsstack';
  static const news = 'newsstack/news';
  static const webview = 'newsstack/webview';

  //Products
  static const productstack = '/productstack';
  static const detail = 'productstack/detail';
  static const products = 'productstack/products';

  //Login
  static const usersStack = '/users';
  static const login = 'users/login';

  static final Map<String, WidgetBuilder> _route = {
    home: (BuildContext context) => HomePage(),
    contact: (contact) => ContactPage(),
    about: (context) => AboutPage(),
    covid: (context) => CovidPage(),
    detail: (context) => DetailPageV2(),
    products: (context) => ProductPageV2(),
    login: (context) => LoginPage(),
    company: (context) => CompanyPage(),
    room: (context) => RoomPageV2(),
  };
  static Map<String, WidgetBuilder> getPage() => _route;
}
