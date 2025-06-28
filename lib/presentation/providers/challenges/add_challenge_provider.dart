import 'package:dooit/data/repositories/challenge_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddChallengeProvider extends ChangeNotifier {
  final ChallengeRepository challengeRepository = ChallengeRepository();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController betPointController = TextEditingController();
  String challengeType = '';
  int maxMinutes = 0;
  int hour = 0;
  int minutes = 0;
  int targetMinutes = 0;
  DateTime nowDate = DateTime.now();
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();
  bool selectDate = false;

  PageController pageController = PageController();
  int pageIndex = 0;

  void changeStep(int index) {
    pageController.jumpToPage(index);
    pageIndex = index;
    notifyListeners();
  }

  void changeChallengeType(String type) {
    challengeType = type;
    notifyListeners();
  }

  void setMaxMinutes() {
    if (challengeType == 'TOTAL') {
      // print(start);
      // print(end);
      maxMinutes = 24 * 60 * (end.difference(start).inDays + 2);
    } else {
      maxMinutes = 24 * 60;
    }
    print(maxMinutes);
  }

  void setHour(int value) {
    hour = value;
    targetMinutes = hour * 60 + minutes;
    notifyListeners();
  }

  void setMinutes(int value) {
    minutes = value;
    targetMinutes = hour * 60 + minutes;
    notifyListeners();
  }

  void setDate(List<DateTime> dates) {
    start = dates[0];
    print(start);
    end = dates[1];
    print(end);
    print(end.difference(start).inDays + 1);
    setMaxMinutes();
    notifyListeners();
  }

  String checkInfo() {
    if(!selectDate) {
      return "기간을 선택해주세요";
    } else if(targetMinutes == 0) {
      return "운동 시간을 정해주세요";
    } else if(betPointController.text.isEmpty || int.parse(betPointController.text) == 0) {
      return "참가 포인트의 개수를 정해주세요";
    }
    return "";
  }

  Future<String> addChallenge(BuildContext context) async {
    final result = await challengeRepository.addChallenge(
      titleController.text,
      descriptionController.text,
      challengeType,
      int.parse(betPointController.text),
      targetMinutes,
      DateFormat('yyyy-MM-dd').format(start),
      DateFormat('yyyy-MM-dd').format(end),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result))
    );
    if(result.contains('성공')) {
      Navigator.of(context).pop();
    }
    return result;
  }
}