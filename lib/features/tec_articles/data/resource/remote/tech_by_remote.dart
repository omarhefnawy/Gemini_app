import 'dart:convert';

import 'package:ai_sample/features/tec_articles/data/model/tech_news_model.dart';
import 'package:dio/dio.dart';
import 'package:ai_sample/core/shared/const.dart';

abstract class RemoteMethods {
  Future<List<TechModel>> remote();
}

class RemoteByDio implements RemoteMethods {
  final dio = Dio();
  @override
  Future<List<TechModel>> remote() async {
    // TODO: implement remote
    try {
      final response = await dio.get(
          '${baseurl}/news?apikey=${apikey}&language=en&category=technology');
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data['results'];
        return jsonData.map((e) => TechModel.fromJson(e)).toList();
      }
      throw Exception('Failed to load articles: ${response.statusCode}');
    } catch (e) {
      // Handle any exceptions
      throw Exception('Failed to load articles: $e');
    }
  }
}
