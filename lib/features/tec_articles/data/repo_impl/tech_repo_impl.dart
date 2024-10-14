import 'package:ai_sample/features/tec_articles/data/resource/remote/tech_by_remote.dart';
import 'package:ai_sample/features/tec_articles/domain/entities/tech_article.dart';
import 'package:ai_sample/features/tec_articles/domain/repo/tech_article_repo.dart';

class RepoImp implements ArticleRepo {
  final RemoteMethods remote;
  RepoImp({required this.remote});
  @override
  Future<List<ArticleEntity>> getArticle() async {
    // TODO: implement getArticle
    return await remote.remote();
  }
}
