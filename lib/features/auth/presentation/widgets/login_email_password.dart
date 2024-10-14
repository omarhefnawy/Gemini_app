import 'package:ai_sample/core/shared/navigate.dart';
import 'package:ai_sample/features/chat_boot/presentation/chat_boot.dart';
import 'package:ai_sample/features/tec_articles/domain/entities/tech_article.dart';
import 'package:ai_sample/features/tec_articles/presentation/screens/article_news.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

Future<void> Login({
  required GlobalKey<FormState> formkey,
  required BuildContext context,
  required String email,
  required String password,
  required List<ArticleEntity> articles,
}) async {
  if (formkey.currentState!.validate()) {
    {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (FirebaseAuth.instance!.currentUser!.emailVerified) {
          navigateWithoutBack(
              context: context, screen: TechNewsScreen(articles: articles));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Not verified.'),
              duration: Duration(seconds: 6),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              title: 'user-not-found');
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              title: 'user-not-found');
          print('Wrong password provided for that user.');
        } else {
          AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              title: 'error while regesrtation');
        }
      }
    }
  }
}
