import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CompanyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('company'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Card(
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/buildaing.png'),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'sing3demons',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                      textAlign: TextAlign.left,
                    ),
                    Divider(),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [FaIcon(FontAwesomeIcons.phone)],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [Text('kpsing')],
                            ),
                            Row(
                              children: [Text('099999999')],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    Wrap(
                      spacing: 8,
                      children: List.generate(
                        7,
                        (int index) => Chip(label: Text('Text : ${index + 1}')),
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/obito.jpg'),
                          radius: 40,
                        ),
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/obito.jpg'),
                          radius: 40,
                        ),
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/obito.jpg'),
                          radius: 40,
                        ),
                        SizedBox(
                          width: 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(Icons.ac_unit),
                              Icon(Icons.sanitizer),
                              Icon(Icons.accessible),
                            ],
                          ),
                        )
                      ],
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
