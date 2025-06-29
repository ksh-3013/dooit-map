import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';

final MyProvider myProvider = MyProvider();

class MyProvider extends ChangeNotifier {
  final UserRepository userRepository = UserRepository();
  UserModel? userData;
  final nameController = TextEditingController();
  String nameError = '유저 이름은 2자 이상 20자 이하여야 합니다.';

  int? hour;
  int? minutes;

  void setTime() {
    hour = (userData!.totalExerTime) ~/ 60;
    minutes = (userData!.totalExerTime) % 60;
    notifyListeners();
  }

  Future<void> getMyData() async {
    userData = await userRepository.getMyData();
    notifyListeners();
  }

  Future<void> changeName() async {
    nameError = await userRepository.changeUserName(nameController.text);
    notifyListeners();
  }

  List<Map<String, dynamic>> myActivity = [
    {
      'icon': Icons.edit,
      'text': '내가 쓴 리뷰',
      'function': () {
        print('내가 쓴 리뷰');
      },
    },
    {
      'icon': Icons.chat_outlined,
      'text': '두잇 토크 활동',
      'function': () {
        print('두잇 토크 활동');
      },
    },
    {
      'icon': Icons.credit_card,
      'text': '결제 내역',
      'function': () {
        print('결제 내역');
      },
    },
    {
      'icon': Icons.favorite_outline,
      'text': '관심 헬스장',
      'function': () {
        print('관심 헬스장');
      },
    },
  ];
}
