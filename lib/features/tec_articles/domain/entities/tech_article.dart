import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final String? title;
  final String? description;
  final String? pubDate;
  final String? imageUrl;
  final String? source_name;
  // Constructor for Entity
  ArticleEntity({
    required this.title,
    required this.description,
    required this.pubDate,
    required this.imageUrl,
    required this.source_name,
  });
  @override
  // TODO: implement props
  List<Object?> get props =>
      [title, description, pubDate, imageUrl, source_name];
}
