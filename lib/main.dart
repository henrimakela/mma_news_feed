import 'package:flutter/material.dart';
import 'package:mma_news/core/bloc/rss_feed_bloc.dart';
import 'package:mma_news/main_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<RssFeedBloc>(
      create: (context) => RssFeedBloc(),
      dispose: (context, value) => value.dispose(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MainPage()),
    );
  }
}
