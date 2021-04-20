import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:intl/intl.dart';

class DetailPageV2 extends StatefulWidget {
  @override
  _DetailPageV2State createState() => _DetailPageV2State();
}

class _DetailPageV2State extends State<DetailPageV2> {
  Map<String, dynamic> course;
  List<dynamic> charpter;
  bool isLoading = true;

  var fNumber = NumberFormat('#,###');

  void _fetchData(int id) async {
    Uri url = Uri.parse('https://api.codingthailand.com/api/course/$id');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> detail = convert.jsonDecode(response.body);
      setState(() {
        charpter = detail['data'];
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _fetchData(course['id']);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    course = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('${course['title']}'),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemBuilder: (context, index) => ListTile(
                    title: Text('${charpter[index]['ch_title']}'),
                    subtitle: Text('${charpter[index]['ch_dateadd']}'),
                    trailing: Chip(
                      label:
                          Text('${fNumber.format(charpter[index]['ch_view'])}'),
                    ),
                  ),
              separatorBuilder: (context, index) => Divider(),
              itemCount: charpter.length),
    );
  }
}
