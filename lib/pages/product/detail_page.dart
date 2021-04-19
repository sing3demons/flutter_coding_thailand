import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/models/datail.dart';
import 'package:intl/intl.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  DetailPage({Key key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Map<String, dynamic> course;
  List<Charpter> charpter = [];
  bool isLoading = true;
  NumberFormat numberFormat = new NumberFormat('#,###');

  _fatchData(int id) async {
    Uri url = Uri.parse('https://api.codingthailand.com/api/course/$id');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      Detail detail = new Detail.fromJson(json);
      // print(json);
      setState(() {
        charpter = detail.charpter;
        isLoading = false;
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () => _fatchData(course['id']),
    );
  }

  @override
  Widget build(BuildContext context) {
    course = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('${course['title']}'),
        automaticallyImplyLeading: true,
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemBuilder: (context, index) => ListTile(
                    title: Text('item ${charpter[index].chTitle}'),
                    subtitle: Text('item ${charpter[index].chDateadd}'),
                    trailing: Chip(
                      label: Text(
                          ' ${numberFormat.format(charpter[index].chView)}'),
                    ),
                  ),
              separatorBuilder: (context, index) => Divider(),
              itemCount: charpter.length),
    );
  }
}
