import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/widgets/menu.dart';
import 'package:http/http.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  bool isLoading = true;
  List<dynamic> articles = [];
  int totalResults = 0;

  fetchArticle() async {
    var apiKey = '15af886eb2504a9cbab0a7431481c331';
    Uri url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=th&apiKey=$apiKey');
    final response = await get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);

      setState(() {
        articles = json['articles'];
        totalResults = json['totalResults'];
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchArticle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข่าวสาร $totalResults'),
      ),
      drawer: Menu(),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _buildListView(),
    );
  }

  _buildListView() => ListView.separated(
      itemBuilder: (context, index) => Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: articles[index]['urlToImage'] != null ||
                                articles[index]['urlToImage'] == ''
                            ? Ink.image(
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage(articles[index]['urlToImage']))
                            : Ink.image(
                                image: AssetImage(
                                    'assets/images/no-image-icon.png'),
                                fit: BoxFit.cover,
                              ),
                      ),
                      Positioned(
                        bottom: 16,
                        right: 16,
                        top: 16,
                        left: 16,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            '${articles[index]['source']['name']}',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${articles[index]['title']}'),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          articles[index]['author'] != null ||
                                  articles[index]['author'] == ''
                              ? Chip(
                                  label: articles[index]['author'].length <= 20
                                      ? Text('${articles[index]['author']}')
                                      : Text(
                                          articles[index]['author']
                                              .substring(0, 20),
                                        ))
                              : Text(''),
                          Text(
                            DateFormat.yMd().add_Hms().format(
                                  DateTime.parse(
                                      articles[index]['publishedAt']),
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      separatorBuilder: (context, index) => Divider(),
      itemCount: articles.length);
}