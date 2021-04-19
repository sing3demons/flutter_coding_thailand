import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/widgets/menu.dart' as mainMenu;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CovidPage extends StatefulWidget {
  CovidPage({Key key}) : super(key: key);

  @override
  _CovidPageState createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage> {
  Map<String, dynamic> data;
  _getApi() async {
    var url = Uri.parse('https://covid19.th-stat.com/api/open/today');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      setState(() {
        data = json['Confirmed'];
      });

      print(data);
    }
  }

  @override
  void initState() {
    _getApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter'),
      ),
      drawer: mainMenu.Menu(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/bg.jpg'),
          ),
        ),
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            GestureDetector(
              child: Container(
                color: Colors.pink,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      'ติดเชื้อสะสม : ${data.toString()}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                color: Colors.pink,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      'ติดเชื้อวันนี้',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
