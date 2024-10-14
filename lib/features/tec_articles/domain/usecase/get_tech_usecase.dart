import 'package:ai_sample/features/tec_articles/domain/entities/tech_article.dart';
import 'package:ai_sample/features/tec_articles/domain/repo/tech_article_repo.dart';
import 'package:flutter/material.dart';

class GetTechUsecase {
  final ArticleRepo article_repo;
  GetTechUsecase({required this.article_repo});
  Future<List<ArticleEntity>> call() async {
    try {
      return await article_repo.getArticle();
    } catch (e) {
      // Handle any errors that occur during the API call
      throw Exception('Failed to get article: $e');
    }
  }
}
