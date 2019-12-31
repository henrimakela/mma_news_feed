import 'package:flutter/material.dart';
import 'package:mma_news/ui/widgets/mma_fighting_feed.dart';
import 'package:mma_news/ui/widgets/mma_junkie_feed.dart';
import 'package:mma_news/ui/widgets/mma_viking_feed.dart';
import 'package:mma_news/ui/widgets/ufc_feed.dart';
import 'package:webfeed/webfeed.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  RssFeed rss;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(
              title: Text("MMA News Feed"),
              bottom: TabBar(
                labelStyle: TextStyle(),
                indicatorColor: Colors.white,
                labelPadding: EdgeInsets.all(0.0),
                tabs: [
                  Tab(
                    text: "MMA Viking",
                  ),
                  Tab(text: "UFC"),
                  Tab(text: "MMA Junkie"),
                  Tab(text: "MMA Fighting"),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                MMAVikingFeedWidget(),
                UFCFeedWidget(),
                MMAJunkieFeedWidget(),
                MMAFightingFeedWidget()
              ],
            )));
  }
}
