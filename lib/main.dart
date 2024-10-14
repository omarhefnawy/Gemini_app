import 'package:ai_sample/core/shared/const.dart';
import 'package:ai_sample/features/auth/presentation/screens/login.dart';
import 'package:ai_sample/features/auth/presentation/screens/sign_up.dart';
import 'package:ai_sample/features/tec_articles/data/repo_impl/tech_repo_impl.dart';
import 'package:ai_sample/features/tec_articles/data/resource/remote/tech_by_remote.dart';
import 'package:ai_sample/features/tec_articles/domain/entities/tech_article.dart';
import 'package:ai_sample/features/tec_articles/domain/repo/tech_article_repo.dart';
import 'package:ai_sample/features/tec_articles/domain/usecase/get_tech_usecase.dart';
import 'package:ai_sample/features/tec_articles/presentation/screens/article_news.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:splashify/splashify.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  RemoteMethods remote = RemoteByDio();
  ArticleRepo repo = RepoImp(remote: remote);
  final usecase = GetTechUsecase(article_repo: repo);
  var fetchedArticles = await usecase.call();
  SignUp sign = SignUp(fetchedArticles);
  Gemini.init(apiKey: gemini_key);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(articles: fetchedArticles));
  //
  // // Assume fetchedArticles is List<ArticleEntity>
  // print(fetchedArticles[0].source_name);
}

class MyApp extends StatelessWidget {
  final List<ArticleEntity> articles;
  MyApp({required this.articles});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashify(
        fadeInNavigation: true,
        blurIntroAnimation: true,
        imageSize: 300,
        titleColor: Colors.white,
        titleBold: true,
        titleSize: 30,
        title: 'Gemini Connect',
        subTitle: Text(
          "Engage in Thoughtful Conversations",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.grey, // Title color
          ),
        ),
        imagePath: 'assets/images/splash.jpg',
        navigateDuration:
            5, // Automatically navigate to the main screen after 3 seconds
        child: (FirebaseAuth.instance!.currentUser != null &&
                FirebaseAuth.instance!.currentUser!.emailVerified)
            ? TechNewsScreen(articles: articles)
            : LoginScreen(
                articles,
              ), // , // Main application screen
        backgroundColor: Color(0xFF1A1A2E), // Dark background for a modern look
        //
      ),
    );
  }
}
