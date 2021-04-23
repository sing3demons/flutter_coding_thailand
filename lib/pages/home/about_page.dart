import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_coding_thailand/redux/reducer/app_reducer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/routes/routes.dart';
import 'package:http/http.dart' as http;

class AboutPage extends StatefulWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

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
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: buildCenter(msg, context),
      ),
    );
  }

  Center buildCenter(Map msg, BuildContext context) {
    return Center(
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
          StoreConnector<AppState, Map<String, dynamic>>(
            distinct: true,
            converter: (store) => store.state.profileState.profile,
            builder: (context, profile) => Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text('About Page'),
                profile != null ? Text('email: ${profile['email']}') : Text(''),
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                        context, profile != null ? '${profile['name']}' : '');
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
        ],
      ),
    );
  }
}
