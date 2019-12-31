import 'package:flutter/material.dart';
import 'package:mma_news/core/bloc/rss_feed_bloc.dart';
import 'package:mma_news/ui/widgets/webview_page.dart';
import 'package:provider/provider.dart';
import 'package:webfeed/webfeed.dart';
import 'package:html/parser.dart' show parse;

class MMAFightingFeedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AtomFeed>(
        stream: Provider.of<RssFeedBloc>(context).mmaFightingStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            AtomFeed feed = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ExpansionTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          feed.items[index].title,
                          style: TextStyle(fontSize: 24.0),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          feed.items[index].updated,
                          style: TextStyle(fontSize: 14.0),
                        )
                      ],
                    ),
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebViewPage(
                                      url: feed.items[index].id,
                                    )),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(0.0),
                                child: Icon(
                                  Icons.web,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("To the article",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          parse(feed.items[index].content ?? "")
                              .documentElement
                              .text,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: feed.items.length,
            );
          }
          return CircularProgressIndicator();
        });
  }
}
