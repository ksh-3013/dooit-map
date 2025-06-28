import 'package:capstone_project_2/data/models/challenge/challenge_model.dart';
import 'package:capstone_project_2/data/models/challenge/my_progress_model.dart';
import 'package:capstone_project_2/data/repositories/challenge_repository.dart';
import 'package:flutter/cupertino.dart';

class DetailChallengeProvider extends ChangeNotifier {

  final ChallengeRepository challengeRepository = ChallengeRepository();
  ChallengeModel? challenge;
  List<MyProgressModel> myProgressList = [];

  Future<void> getChallenge(int id) async {
    challenge = await challengeRepository.getChallenge(id);
    notifyListeners();
  }

  String getStartDate() {
    String getDate = '';
    for(int i = 5; i < challenge!.startDate.length; i++) {
      getDate += challenge!.startDate[i];
    }
    return getDate;
  }

  String getEndDate() {
    String getDate = '';
    for(int i = 5; i < challenge!.endDate.length; i++) {
      getDate += challenge!.endDate[i];
    }
    return getDate;
  }

  String getDate(String date) {
    String getDate = '';
    for(int i = 5; i < date.length; i++) {
      getDate += date[i];
    }
    return getDate;
  }

  Future<String> joinChallenge(int id) async {
    return await challengeRepository.joinChallenge(id);
  }

  void setThreeDays() {

    final index = challenge!.myProgressList!.indexWhere((element) => element.today,);
    List<MyProgressModel> myProgressList = [];
    for(int i = index; i < index + 3; i++) {
      myProgressList.add(challenge!.myProgressList![i]);
    }
    this.myProgressList = myProgressList;
  }

}