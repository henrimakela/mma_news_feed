import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

class RSSRepository {

  static const  MMA_VIKING_RSS_FEED = "https://www.mmaviking.com/feed/";
  static const MMA_JUNKIE_RSS_FEED = "https://mmajunkie.usatoday.com/news/feed";
  static const MMA_FIGHTING_ATOM_FEED = "https://www.mmafighting.com/rss/current";
  static const UFC_RSS_FEED  = "https://www.ufc.com/rss/news";

  Future<RssFeed> fetchRSSFeed(String url) async {
    var response = await http.get(url);
    return RssFeed.parse(response.body);
  }

  Future<AtomFeed> fetchAtomFeed(String url) async {
    var response = await http.get(url);
    return AtomFeed.parse(response.body);
  }
}
