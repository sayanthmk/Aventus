import 'package:aventus/model/postmodel.dart';
import 'package:aventus/services/service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SyncService {
  static Future<List<PostModel>> getLocalPosts() async {
    final box = await Hive.openBox<PostModel>('posts');
    return box.values.toList();
  }

  static Future<void> syncPosts() async {
    final connectivity = await Connectivity().checkConnectivity();
    final box = await Hive.openBox<PostModel>('posts');

    if (connectivity != ConnectivityResult.none) {
      try {
        final posts = await ApiService.fetchPosts();
        await box.clear();
        for (var post in posts) {
          await box.put(post.id, post);
        }
      } catch (e) {
        debugPrint('Sync error: $e');
        throw Exception('Failed to sync posts');
      }
    }
  }
}
