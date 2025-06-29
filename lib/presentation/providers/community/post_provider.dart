import 'package:flutter/cupertino.dart';

import '../../../data/models/post_model.dart';

class PostProvider extends ChangeNotifier {
  PostModel? postData;

  void getPostData() {
    postData = PostModel(id: 16,
        title: '하루 살이',
        content: '끝까지 넌 참 많은걸 가르쳐 내가 몰랐던 것들을 알게해\n어쩌면 날 버리고 떠나서도 계속 내 주변을 맴도는듯해 사랑을 가려져 기쁨알게하고 이별을 가르져 눈물 알게하고 술 마시면 또 보고싶어 왜 잊는법은 안 가르지고 떠난 거야',
        authorName: 'quswldn',
        authorId: 89,
        authorTier: '헬고수',
        commentCount: 40,
        createdAt: '2025-06-05',
        updatedAt: null,
      reactionCount: 25,
      authorProfile: 1,
    );
    notifyListeners();
  }
}