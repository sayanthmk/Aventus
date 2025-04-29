import 'package:aventus/controller/post_controller.dart';
import 'package:aventus/controller/themecontroller.dart';
import 'package:aventus/model/postmodel.dart';
import 'package:aventus/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PostModelAdapter());
  await Hive.openBox<PostModel>('posts');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(
          create: (_) => PostProvider()..loadPosts(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Themed Sync App',
      theme: themeNotifier.currentTheme,
      home: const HomeScreen(),
    );
  }
}
