import 'package:ai_sample/features/tec_articles/domain/entities/tech_article.dart';

abstract class ArticleRepo {
  Future<List<ArticleEntity>> getArticle();
}
