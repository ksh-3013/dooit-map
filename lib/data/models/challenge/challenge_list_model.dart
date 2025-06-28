import 'package:dooit/data/models/challenge/view_challenge_model.dart';

class ChallengeListModel {
  final bool last;
  final int total_elements;
  final int total_pages;
  final bool first;
  final int number_of_elements;
  final List<ViewChallengeModel> content;

  ChallengeListModel({
    required this.last,
    required this.total_elements,
    required this.total_pages,
    required this.first,
    required this.number_of_elements,
    required this.content,
  });

  factory ChallengeListModel.fromJson(Map<String, dynamic> json) {
    List<ViewChallengeModel> challengeList = [];
    for (var challenge in json['content']) {
      challengeList.add(ViewChallengeModel.fromJson(challenge));
    }
    return ChallengeListModel(
      last: json['last'],
      total_elements: json['total_elements'],
      total_pages: json['total_pages'],
      first: json['first'],
      number_of_elements: json['number_of_elements'],
      content: challengeList,);
  }
}
