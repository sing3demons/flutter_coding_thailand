import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/models/product.dart';
import 'package:flutter_coding_thailand/routes/routes.dart';
import 'package:flutter_coding_thailand/widgets/menu.dart' as mainMenu;
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ProductPageV2 extends StatefulWidget {
  ProductPageV2({Key key}) : super(key: key);

  @override
  _ProductPageV2State createState() => _ProductPageV2State();
}

class _ProductPageV2State extends State<ProductPageV2> {
  List<dynamic> course;
  bool isLoading = true;

  void _fetchData() async {
    Uri url = Uri.parse('https://api.codingthailand.com/api/course');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> product = convert.jsonDecode(response.body);
      setState(() {
        course = product['data'];
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        automaticallyImplyLeading: true,
      ),
      drawer: mainMenu.Menu(),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _buildListView(),
    );
  }

  ListView _buildListView() => ListView.separated(
      itemBuilder: (context, index) => ListTile(
            title: Text('${course[index]['title']}'),
            subtitle: Text('${course[index]['detail']}'),
            leading: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    course[index]['picture'],
                  ),
                ),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.detail, arguments: {
                'id': course[index]['id'],
                'title': course[index]['title'],
              });
            },
          ),
      separatorBuilder: (context, index) => Divider(),
      itemCount: course.length);
}
