import 'package:aventus/constants/constants.dart';
import 'package:aventus/controller/post_controller.dart';
import 'package:aventus/controller/themecontroller.dart';
import 'package:aventus/view/theme_page.dart';
import 'package:aventus/view/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        heading: 'Aventus',
        appbaractions: [
          Consumer<ThemeNotifier>(
            builder: (context, themeNotifier, child) {
              return PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'Light':
                      themeNotifier.switchTheme(AppThemes.lightTheme);
                      break;
                    case 'Dark':
                      themeNotifier.switchTheme(AppThemes.darkTheme);
                      break;
                    case 'Custom':
                      themeNotifier.switchTheme(AppThemes.appTheme);
                      break;
                  }
                },
                icon: const Icon(Icons.color_lens),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                      value: 'Light', child: Text('Light Theme')),
                  const PopupMenuItem(value: 'Dark', child: Text('Dark Theme')),
                  const PopupMenuItem(
                      value: 'Custom', child: Text('Custom Theme')),
                ],
              );
            },
          ),
        ],
      ),
      body: Consumer<PostProvider>(
        builder: (context, postProvider, child) {
          if (postProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (postProvider.posts.isEmpty) {
            return const Center(child: Text('No Posts Available'));
          }

          return RefreshIndicator(
            onRefresh: () => postProvider.refreshPosts(),
            child: ListView.builder(
              itemCount: postProvider.posts.length,
              itemBuilder: (ctx, index) {
                final post = postProvider.posts[index];
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
            ),
          );
        },
      ),
    );
  }
}
