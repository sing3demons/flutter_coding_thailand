import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/routes/routes.dart';
import 'package:http/http.dart' as http;

class AboutPage extends StatefulWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Future<Map<String, dynamic>> fetchData() async {
    Uri url = Uri.parse('https://api.codingthailand.com/api/version');
    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> version = jsonDecode(response.body);
      print(version);
      return version;
    } else {
      throw Exception('Failed to load version ${response.statusCode}');
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map msg = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('เกี่ยวกับเรา'),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<Map<String, dynamic>>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('version ${snapshot.data['data']['version']}');
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
            Text('About Page'),
            Text('email: ${msg['email']}'),
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'KPSING');
              },
              child: Text('go to home'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.contact);
              },
              child: Text('contact'),
            ),
          ],
        ),
      ),
    );
  }
}
