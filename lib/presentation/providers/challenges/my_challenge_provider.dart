import 'package:flutter/cupertino.dart';

import '../../../data/models/challenge/challenge_model.dart';
import '../../../data/repositories/challenge_repository.dart';

class MyChallengeProvider extends ChangeNotifier {
  final ChallengeRepository challengeRepository = ChallengeRepository();
  ChallengeModel? myChallenge;

  Future<void> getMyChallenge() async {
    final myChallengeId = await challengeRepository.getMyChallengeId();
    myChallenge = myChallengeId == null ? null : await challengeRepository.getChallenge(myChallengeId);
    notifyListeners();
  }

}