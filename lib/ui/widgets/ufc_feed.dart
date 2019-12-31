import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mma_news/core/bloc/rss_feed_bloc.dart';
import 'package:mma_news/ui/widgets/webview_page.dart';
import 'package:provider/provider.dart';
import 'package:webfeed/webfeed.dart';
import 'package:html/parser.dart' show parse;

class UFCFeedWidget extends StatefulWidget {
  @override
  _UFCFeedWidgetState createState() => _UFCFeedWidgetState();
}

class _UFCFeedWidgetState extends State<UFCFeedWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RssFeed>(
        stream: Provider.of<RssFeedBloc>(context).ufcStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            RssFeed feed = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ExpansionTile(title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(feed.items[index].title, style: TextStyle(fontSize: 24.0),),
                          SizedBox(height: 10,),
                          Text(feed.items[index].pubDate ?? "", style: TextStyle(fontSize: 14.0),),
                        ],
                      ),
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WebViewPage(
                                      url: feed.items[index].link,
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

                          )
                        ],

                    ));
              },
              itemCount: feed.items.length,
            );
          }
          return CircularProgressIndicator();
        });
  }
}
