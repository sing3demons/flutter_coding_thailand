import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class RoomPageV2 extends StatefulWidget {
  RoomPageV2({Key key}) : super(key: key);

  @override
  _RoomPageV2State createState() => _RoomPageV2State();
}

class _RoomPageV2State extends State<RoomPageV2> {
  // bool isLoading = true;
  List<dynamic> room;

  Future<List<dynamic>> futureData;

  Future<List<dynamic>> fetchData() async {
    Uri url = Uri.parse('https://codingthailand.com/api/get_rooms.php');
    final response = await get(url);

    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      return room = json;
    } else {
      throw Exception('Failed to load room ${response.statusCode}');
    }
  }

  @override
  void initState() {
    futureData = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room'),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: futureData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                        title: Text('${snapshot.data[index]['name']}'),
                        subtitle: Text('${snapshot.data[index]['status']}'),
                        trailing: Chip(
                          label: Text('${snapshot.data[index]['id']}'),
                        ),
                      ),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: room.length);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
