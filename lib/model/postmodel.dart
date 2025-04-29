import 'package:hive/hive.dart';

part 'postmodel.g.dart';

@HiveType(typeId: 0)
class PostModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String body;

  PostModel({required this.id, required this.title, required this.body});

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      PostModel(id: json['id'], title: json['title'], body: json['body']);
}
