import 'package:flutter/cupertino.dart';

class CommunityProvider extends ChangeNotifier {

  String selectCategory = '전체';
  String sort = '';

  void changeCategory(String newCategory) {
    selectCategory = newCategory;
    notifyListeners();
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

}