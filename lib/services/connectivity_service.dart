import 'package:aventus/model/postmodel.dart';
import 'package:aventus/services/service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';

class SyncService {
  static Future<void> syncPosts() async {
    final connectivity = await Connectivity().checkConnectivity();
    final box = Hive.box<PostModel>('posts');

    if (connectivity != ConnectivityResult.none) {
      final posts = await ApiService.fetchPosts();
      await box.clear();
      for (var post in posts) {
        await box.put(post.id, post);
      }
    }
  }
}
