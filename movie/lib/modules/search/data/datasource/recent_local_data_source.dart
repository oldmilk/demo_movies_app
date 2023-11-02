import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie/modules/search/data/models/recent_model.dart';

abstract class RecentLocalDataSource {
  Future<List<RecentModel>> getRecentItems();
  Future<RecentModel> addRecentItem(RecentModel recent);
  Future<RecentModel> removeRecentItem(RecentModel recent);
}

class RecentLocalDataSourceImpl extends RecentLocalDataSource {
  final Box _box = Hive.box('recents');

  @override
  Future<List<RecentModel>> getRecentItems() async {
    return _box.values
        .map((e) => RecentModel.fromEntity(e))
        .toList()
        .reversed
        .toList();
  }

  @override
  Future<RecentModel> addRecentItem(RecentModel recent) async {
    _box.put(recent.item, recent);
    return recent;
  }

  @override
  Future<RecentModel> removeRecentItem(RecentModel recent) async {
    _box.delete(recent.item);
    return recent;
  }
}
