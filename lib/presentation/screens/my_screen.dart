import 'package:flutter/material.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';

/// 전역 인스턴스 대신 ProviderScope/Riverpod 등을 쓰면 좋지만,
/// 현 구조 유지 차원에서 싱글턴으로 노출합니다.
final myProvider = MyProvider();

class MyProvider extends ChangeNotifier {
  // -------------------------------------------------------------------------
  // Dependencies
  // -------------------------------------------------------------------------
  final UserRepository _userRepository = userRepository;

  // -------------------------------------------------------------------------
  // 상태 값
  // -------------------------------------------------------------------------
  UserModel? _user; // null: 아직 로드 안 됨
  String _nameError = '유저 이름은 2자 이상 20자 이하여야 합니다.';
  final TextEditingController nameController = TextEditingController();

  // 시간 계산용 getter (분 단위 저장이므로 60으로 계산)
  int get hour => (_user?.totalExerTime ?? 0) ~/ 60;

  int get minutes => (_user?.totalExerTime ?? 0) % 60;

  // 외부에서 읽기용 getter --------------------------------------------------
  UserModel? get userData => _user;

  String get nameError => _nameError;

  bool get isLoaded => _user != null;

  // -------------------------------------------------------------------------
  // API 호출
  // -------------------------------------------------------------------------
  Future<void> fetchMyData() async {
    _user = await _userRepository.getMyData();
    notifyListeners();
  }

  Future<void> changeName() async {
    if (nameController.text.trim().length < 2 ||
        nameController.text.trim().length > 20) {
      _nameError = '유저 이름은 2자 이상 20자 이하여야 합니다.';
      notifyListeners();
      return;
    }

    _nameError = await _userRepository.changeUserName(
      nameController.text.trim(),
    );
    await fetchMyData(); // 이름 변경 후 내 정보 갱신
  }

  // -------------------------------------------------------------------------
  // My Activity List (static)
  // -------------------------------------------------------------------------
  List<Map<String, dynamic>> get myActivity => _myActivity;

  final List<Map<String, dynamic>> _myActivity = [
    {
      'icon': Icons.edit,
      'text': '내가 쓴 리뷰',
      'action': () => debugPrint('내가 쓴 리뷰'),
    },
    {
      'icon': Icons.chat_outlined,
      'text': '두잇 토크 활동',
      'action': () => debugPrint('두잇 토크 활동'),
    },
    {
      'icon': Icons.credit_card,
      'text': '결제 내역',
      'action': () => debugPrint('결제 내역'),
    },
    {
      'icon': Icons.favorite_outline,
      'text': '관심 헬스장',
      'action': () => debugPrint('관심 헬스장'),
    },
  ];
}
