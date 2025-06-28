import 'package:capstone_project_2/data/models/post_model.dart';
import 'package:flutter/cupertino.dart';

class PostProvider extends ChangeNotifier {
  PostModel? postData;

  void getPostData() {
    postData = PostModel(id: 16,
        title: '하루 살이',
        content: '아 배고픈데 짜장면 먹을까요 아니면 그냥 계속 운동할까요',
        authorName: 'quswldn',
        authorId: 89,
        authorTier: '헬고수',
        commentCount: 40,
        createdAt: '2025-06-05',
        updatedAt: null);
    notifyListeners();
  }
}