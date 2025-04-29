import 'dart:async';
import 'package:aventus/controller/themecontroller.dart';
import 'package:aventus/model/postmodel.dart';
import 'package:aventus/services/connectivity_service.dart';
import 'package:aventus/view/theme_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<PostModel> postBox;

  @override
  void initState() {
    super.initState();
    postBox = Hive.box<PostModel>('posts');
    SyncService.syncPosts();
    Timer.periodic(const Duration(minutes: 5), (timer) {
      SyncService.syncPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline Posts'),
        actions: [
          Consumer<ThemeNotifier>(
            builder: (context, themeNotifier, _) => Switch(
              value: themeNotifier.currentTheme.brightness == Brightness.dark,
              onChanged: (value) {
                themeNotifier.toggleDarkMode(value);
              },
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: postBox.listenable(),
        builder: (context, box, _) {
          if (box.values.isEmpty) return const Center(child: Text('No Posts'));
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (_, i) {
              final post = box.getAt(i)!;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ThemedContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.title,
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Text(post.body),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
