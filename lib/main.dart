import 'package:flutter/material.dart';
import 'components/header_bar.dart';
import 'components/menu_bar.dart';
import 'components/news_card.dart';
import 'components/big_news_card.dart';
import 'components/section_title.dart';
import 'dart:core';
import 'api_handler.dart';

void main() {
  runApp(MyApp());
}
// ===========================================================================

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      home: Myhomepage(),
      theme:
          ThemeData(scaffoldBackgroundColor: Color.fromRGBO(246, 240, 235, 1)),
    );
  }
}

class Myhomepage extends StatefulWidget {
  const Myhomepage({Key? key}) : super(key: key);

  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  late Future<dynamic> newsData;

  @override
  void initState() {
    super.initState();
    newsData = apiHandler.getNews(["country=th,gb,us", "language=en,th"]);
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Headerbar(),
        drawer: Sidemenu(),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              SectionTitle(title: "Suggestion"),
              BigNewsCard(),
              SectionTitle(title: "Popular Today"),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.48,
                width: MediaQuery.of(context).size.width * 0.9,
                child: FutureBuilder<dynamic>(
                  future: newsData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                NewsCard(
                                    imgUrl: snapshot.data[index]['image_url'],
                                    newsTitle: snapshot.data[index]['title'],
                                    newsDate: snapshot.data[index]['pubDate'],
                                    newsContent: snapshot.data[index]
                                        ['content'],
                                    newsDesc: snapshot.data[index]
                                        ['description'])
                              ],
                            );
                          });
                    }
                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        )));
  }
}
