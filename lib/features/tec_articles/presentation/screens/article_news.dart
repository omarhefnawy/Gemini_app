import 'package:ai_sample/core/shared/navigate.dart';
import 'package:ai_sample/features/auth/presentation/screens/login.dart';
import 'package:ai_sample/features/chat_boot/presentation/chat_boot.dart';
import 'package:ai_sample/features/tec_articles/domain/entities/tech_article.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:cached_network_image/cached_network_image.dart';

class TechNewsScreen extends StatelessWidget {
  final List<ArticleEntity> articles;

  TechNewsScreen({required this.articles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Text(
          'Tech News',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          SizedBox(
            width: 5,
          ),
          TextButton.icon(
            onPressed: () {
              navigate(context: context, screen: ChatBoot());
            },
            icon: Icon(
              FontAwesomeIcons.commentDots, // Chat icon
              color: Colors.white,
            ),
            label: Text(
              ' Gemini Chat',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              navigateWithoutBack(
                  context: context, screen: LoginScreen(articles));
            },
            icon: Icon(
              FontAwesomeIcons.signOut,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 10),
        ],
        backgroundColor: Colors.blueGrey[900],
      ),
      body: articles.isNotEmpty
          ? ListView.separated(
              padding: EdgeInsets.all(8.0),
              itemCount: articles.length,
              separatorBuilder: (_, __) => Divider(),
              itemBuilder: (context, index) {
                final article = articles[index];
                return _buildArticleCard(article, context);
              },
            )
          : Center(
              child: Text(
                'No Articles Available',
                style: TextStyle(fontSize: 18),
              ),
            ),
    );
  }

  Widget _buildArticleCard(ArticleEntity article, BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          // Add navigation or action on tap
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Clicked on: ${article.title}')),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              _buildImage(article.imageUrl.toString()),
              SizedBox(width: 10),
              Expanded(
                child: _buildArticleDetails(article),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String image) {
    return Image.network(
      image ??
          'https://www.industryconnect.org/wp-content/uploads/2018/10/nztech.jpg',
      fit: BoxFit.cover,
      height: 100,
      width: 100,
      errorBuilder: (context, error, stackTrace) {
        return Icon(size: 40, Icons.error);
      },
    );
  }

  Widget _buildArticleDetails(ArticleEntity article) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          article.title ?? 'No Title',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 5),
        Text(
          article.description ?? 'No Description',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              article.source_name ?? 'Unknown Source',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              article.pubDate ?? 'No Date',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
