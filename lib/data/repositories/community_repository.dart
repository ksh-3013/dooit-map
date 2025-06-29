import 'dart:convert';

import 'package:dooit/data/models/post_model.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommunityRepository {

  final client = Client();
  final url = 'https://be-production-e1c4.up.railway.app/api';

  Future<List<PostModel>> getPosts(String keyword, int page, int size, String sort) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      final tkn = pref.getString('access_token');

    final queryParams = {
        'keyword': keyword,
        'page': page.toString(),
        'size': size.toString(),
        'sort': sort,
      };
      // print(queryParams);

      final response = await client.get(
          Uri.parse('${url}/community/post')
              .replace(queryParameters: queryParams),
          headers: {
            'Authorization' : 'Bearer ${tkn}'
          }
      );

      final jsonBody = await jsonDecode(response.body);
      if(response.statusCode >= 200 && response.statusCode < 300) {
        print(jsonBody['data']);
        List<PostModel> postList = [];
        for(var post in jsonBody['data']['posts']) {
          postList.add(PostModel.fromJson(post));
        }
        print('게시글 모두 가져오기 성공!');
        return postList;
      }

      print('게시글 모두 가져오기 실패: ${response.statusCode} ${jsonBody}');
      return [];

    } catch(e) {
      print('게시글 모두 가져오기 에러다: $e');
      return [];
    }
  }

}
