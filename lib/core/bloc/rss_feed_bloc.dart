import 'package:mma_news/core/rss_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webfeed/domain/atom_feed.dart';
import 'package:webfeed/domain/rss_feed.dart';

class RssFeedBloc {
  final _repository = RSSRepository();

  final _ufcRSSFeedStreamContoller = BehaviorSubject<RssFeed>();
  final _mmaVikingRSSFeedStreamContoller = BehaviorSubject<RssFeed>();
  final _mmaJunkieRSSFeedStreamContoller = BehaviorSubject<RssFeed>();
  final _mmaFightingAtomFeedStreamContoller = BehaviorSubject<AtomFeed>();

  Stream<RssFeed> get ufcStream => _ufcRSSFeedStreamContoller.stream;

  Stream<RssFeed> get mmaVikingStream =>
      _mmaVikingRSSFeedStreamContoller.stream;

  Stream<RssFeed> get mmaJunkieStream =>
      _mmaJunkieRSSFeedStreamContoller.stream;

  Stream<AtomFeed> get mmaFightingStream =>
      _mmaFightingAtomFeedStreamContoller.stream;

  RssFeedBloc() {
    _fetchAllFeeds();
  }

  _fetchAllFeeds() async {
    RssFeed mmaVikingFeed =
        await _repository.fetchRSSFeed(RSSRepository.MMA_VIKING_RSS_FEED);
    RssFeed ufcFeed =
        await _repository.fetchRSSFeed(RSSRepository.UFC_RSS_FEED);
    RssFeed mmaJunkieFeed =
        await _repository.fetchRSSFeed(RSSRepository.MMA_JUNKIE_RSS_FEED);
    AtomFeed mmaFightingFeed =
        await _repository.fetchAtomFeed(RSSRepository.MMA_FIGHTING_ATOM_FEED);

    _ufcRSSFeedStreamContoller.sink.add(ufcFeed);
    _mmaVikingRSSFeedStreamContoller.sink.add(mmaVikingFeed);
    _mmaJunkieRSSFeedStreamContoller.sink.add(mmaJunkieFeed);
    _mmaFightingAtomFeedStreamContoller.sink.add(mmaFightingFeed);
  }

  dispose() {
    _ufcRSSFeedStreamContoller.close();
    _mmaFightingAtomFeedStreamContoller.close();
    _mmaJunkieRSSFeedStreamContoller.close();
    _mmaVikingRSSFeedStreamContoller.close();
  }
}
