import 'package:capstone_project_2/data/models/challenge/challenge_list_model.dart';
import 'package:capstone_project_2/data/models/challenge/challenge_model.dart';
import 'package:capstone_project_2/data/models/challenge/view_challenge_model.dart';
import 'package:capstone_project_2/data/repositories/challenge_repository.dart';
import 'package:capstone_project_2/data/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';

final ChallengeProvider challengeProvider = ChallengeProvider();

class ChallengeProvider extends ChangeNotifier {
  final ChallengeRepository challengeRepository = ChallengeRepository();
  final UserRepository userRepository = UserRepository();
  final ScrollController scrollController = ScrollController();
  ChallengeListModel? challengesData;
  List<ViewChallengeModel> challenges = [];

  int point = 0;
  String challengeType = 'ALL'; // TOTAL, DAILY
  String sort = '';
  int page = 0;

  void resetChallenges() {
    challenges = [];
    page = 0;
    notifyListeners();
  }

  void addList() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels >
              scrollController.position.maxScrollExtent - 300 &&
          !challengesData!.last) {
        page += 1;
        await getChallengesData();
      }
    });
  }

  Future<void> getMyData() async {
    point = (await userRepository.getMyData())?.totalPoint ?? 0;
    notifyListeners();
  }

  void changeChallengeType(String type) {
    challengeType = type;
    notifyListeners();
  }

  Future<void> getChallengesData() async {
    challengesData = await challengeRepository.getChallengeList(
      challengeType,
      '',
      page,
      10,
      sort,
    );
    if (challengesData != null && challengesData!.content.isNotEmpty) {
      challenges.addAll(challengesData!.content);
    }
    notifyListeners();
  }

  void setSort(String typeText) {
    sort = textToSort(typeText);
    notifyListeners();
  }

  String sortToText() {
    switch (sort) {
      case 'BETTING_ASC':
        return '포인트 낮은순';
      case 'BETTING_DESC':
        return '포인트 높은순';
      case 'TARGET_MIN_ASC':
        return '목표 시간 적은순';
      case 'TARGET_MIN_DESC':
        return '목표 시간 많은순';
      default:
        return '곧 시작해요!';
    }
  }

  String textToSort(String typeText) {
    switch (typeText) {
      case '포인트 낮은순':
        return 'BETTING_ASC';
      case '포인트 높은순':
        return 'BETTING_DESC';
      case '목표 시간 적은순':
        return 'TARGET_MIN_ASC';
      case '목표 시간 많은순':
        return 'TARGET_MIN_DESC';
      default:
        return '';
    }
  }

}
