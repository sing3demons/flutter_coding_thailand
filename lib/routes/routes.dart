import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/pages/home/about_page.dart';
import 'package:flutter_coding_thailand/pages/home/company_page.dart';
import 'package:flutter_coding_thailand/pages/home/contact_page.dart';
import 'package:flutter_coding_thailand/pages/users/login_page.dart';
import 'package:flutter_coding_thailand/pages/product/detail_page.dart';
import 'package:flutter_coding_thailand/pages/home/home_page.dart';
import 'package:flutter_coding_thailand/pages/product/product_page.dart';

class Routes {
  static const root = '/';
  static const home = 'homestack/home';
  static const contact = 'homestack/contact';
  static const about = 'homestack/about';
  static const company = 'homestack/company';

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
    detail: (context) => DetailPage(),
    products: (context) => ProductPage(),
    login: (context) => LoginPage(),
    company: (context) => CompanyPage(),
  };
  static Map<String, WidgetBuilder> getPage() => _route;
}
