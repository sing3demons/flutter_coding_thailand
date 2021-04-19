import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/models/product.dart';
import 'package:flutter_coding_thailand/widgets/menu.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Course> course = [];
  _getData() async {
    Uri url = Uri.parse('https://api.codingthailand.com/api/course');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
   
      Product product = Product.fromJson(json);
      print(product.course);
      setState(() {
        course = product.course;
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        // automaticallyImplyLeading: false,
      ),
      drawer: Menu(),
      body: ListView.separated(
        itemCount: course.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('item ${course[index].title}'),
            subtitle: Text('item ${course[index].detail}'),
            leading: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage('${course[index].picture}'))),
            ),
          );
        },
      ),
    );
  }
}
