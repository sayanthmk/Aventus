import 'package:aventus/model/postmodel.dart';
import 'package:aventus/services/connectivity_service.dart';
import 'package:flutter/material.dart';

class PostProvider with ChangeNotifier {
  List<PostModel> _posts = [];
  bool _isLoading = true;

  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;

  Future<void> loadPosts() async {
    _isLoading = true;
    notifyListeners();

    try {
      await SyncService.syncPosts();
      _posts = await SyncService.getLocalPosts();
    } catch (e) {
      debugPrint('Error loading posts: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshPosts() async {
    await loadPosts();
  }
}
