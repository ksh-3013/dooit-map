import 'package:dooit/data/models/post_model.dart';
import 'package:flutter/cupertino.dart';
import '../../../data/repositories/community_repository.dart';

class CommunityProvider extends ChangeNotifier {
  final CommunityRepository communityRepository = CommunityRepository();
  final ScrollController scrollController = ScrollController();
  String selectCategory = '전체';
  String sort = '';
  List<PostModel> posts = [];
  List<PostModel> allPosts = [];
  int page = 0;

  void changeCategory(String newCategory) {
    selectCategory = newCategory;
    notifyListeners();
  }

  void resetPosts() {
    allPosts = [];
    page = 0;
    notifyListeners();
  }

  void addList() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels >
              scrollController.position.maxScrollExtent - 300 &&
          posts.isNotEmpty) {
        page += 1;
        await getPosts();
      }
    });
  }

  void setSort(String typeText) {
    sort = textToSort(typeText);
    notifyListeners();
  }

  String sortToText() {
    switch (sort) {
      case 'like':
        return '리액션 많은 순';
      case 'comment':
        return '댓글 많은 순';
      default:
        return '최신순';
    }
  }

  String textToSort(String typeText) {
    switch (typeText) {
      case '리액션 많은 순':
        return 'like';
      case '댓글 많은 순':
        return 'comment';
      default:
        return '';
    }
  }

  Future<void> getPosts() async {
    posts = await communityRepository.getPosts('', page, 10, sort);
    if (posts.isNotEmpty) {
      allPosts.addAll(posts);
    }
    print(posts);
    print('한글${allPosts}');
    notifyListeners();
  }
}
