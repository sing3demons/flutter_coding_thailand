import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/models/room.dart';
import 'package:http/http.dart';

class RoomPage extends StatefulWidget {
  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  bool isLoading = true;
  List<Room> room;

  void _fetchData() async {
    Uri url = Uri.parse('https://codingthailand.com/api/get_rooms.php');
    final response = await get(url);

    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      final Hotel hotal = Hotel.formJson(json);
      setState(() {
        room = hotal.room;
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
        title: Text('Room'),
        automaticallyImplyLeading: true,
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemBuilder: (context, index) => ListTile(
                    title: Text('${room[index].name}'),
                    subtitle: Text('${room[index].status}'),
                    trailing: Chip(
                      label: Text('${room[index].id}'),
                    ),
                  ),
              separatorBuilder: (context, index) => Divider(),
              itemCount: room.length),
    );
  }
}
