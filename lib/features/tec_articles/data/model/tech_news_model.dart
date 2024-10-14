import 'package:ai_sample/features/tec_articles/domain/entities/tech_article.dart';
import 'package:flutter/foundation.dart';

class TechModel extends ArticleEntity {
  TechModel({
    required String description,
    required String imageUrl,
    required String pubDate,
    required String title,
    required String source_name,
  }) : super(
          description: description,
          imageUrl: imageUrl,
          pubDate: pubDate,
          title: title,
          source_name: source_name,
        );
  factory TechModel.fromJson(Map<String, dynamic> json) {
    return TechModel(
      description: json["description"] ?? "",
      imageUrl: json["image_url"] ??
          "https://cdn.businessday.ng/wp-content/uploads/2024/10/15-most-popular-generative-AI-tools-shaping-2024.jpg",
      pubDate: json["pubDate"] ?? "today",
      title: json["title"] ?? "Omar is the new owner",
      source_name: json["source_name"] ?? "",
    );
  }
}
