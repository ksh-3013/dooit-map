import 'package:dooit/common/colors.dart';
import 'package:dooit/common/fonts.dart';
import 'package:dooit/presentation/components/challenge_type_box.dart';
import 'package:dooit/presentation/screens/challenges/add_challenge_screen.dart';
import 'package:dooit/presentation/screens/search_challenge_screen.dart';
import 'package:dooit/presentation/widgets/challenges/challenge_item.dart';
import 'package:dooit/presentation/widgets/challenges/my_challenge_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../providers/challenges/challenge_provider.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  void updateScreen() => setState(() {});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      challengeProvider.addListener(updateScreen);
      await challengeProvider.getChallengesData();
      await challengeProvider.getMyData();
      challengeProvider.addList();
    });
  }

  @override
  void dispose() {
    challengeProvider.removeListener(updateScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6EFE9),
      body: SingleChildScrollView(
        controller: challengeProvider.scrollController,
        child: Column(
          children: [
            SizedBox(height: 70),
            Image.asset(
              'assets/images/challenge_screen_titile.png',
              width: 250,
            ),
            SizedBox(height: 12),
            // 캐릭터 및 참여 챌린지
            MyChallengeWidget(),
            SizedBox(height: 22),

            // 리스트 목록
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: MediaQuery.sizeOf(context).height - 200,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              ),
              child: Column(
                children: [
                  // 스크롤 시 고정 바
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChallengeTypeBox(
                        type: 'ALL',
                        function: () {
                          challengeProvider.resetChallenges();
                          challengeProvider.changeChallengeType('ALL');
                          challengeProvider.getChallengesData();
                        },
                        selectType: challengeProvider.challengeType,
                        height: 30,
                      ),
                      ChallengeTypeBox(
                        type: 'TOTAL',
                        function: () {
                          challengeProvider.resetChallenges();
                          challengeProvider.changeChallengeType('TOTAL');
                          challengeProvider.getChallengesData();
                        },
                        selectType: challengeProvider.challengeType,
                        height: 30,
                      ),
                      ChallengeTypeBox(
                        type: 'DAILY',
                        function: () {
                          challengeProvider.resetChallenges();
                          challengeProvider.changeChallengeType('DAILY');
                          challengeProvider.getChallengesData();
                        },
                        selectType: challengeProvider.challengeType,
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) =>
                                  SearchScreen(searchTarget: '챌린지'),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            border: Border.all(
                              width: 1,
                              color: Colors.grey.withValues(alpha: 0.2),
                            ),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search_rounded,
                                size: 15,
                                color: Colors.black,
                              ),
                              Text(
                                '검색',
                                style: mediumText(
                                  size: 11,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                width: double.infinity,
                                height: 350,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 15),
                                    Container(
                                      width: 50,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          200,
                                        ),
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    _selectSort(text: '곧 시작해요!'),
                                    _selectSort(text: '포인트 낮은순'),
                                    _selectSort(text: '포인트 높은순'),
                                    _selectSort(text: '목표 시간 적은순'),
                                    _selectSort(text: '목표 시간 많은순', last: true),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              challengeProvider.sortToText(),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              size: 20,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    children:
                        challengeProvider.challengesData == null ||
                            challengeProvider.challenges.isEmpty
                        ? [Text('할 수 있는 챌린지가 없어요')]
                        : challengeProvider.challenges
                              .map((e) => ChallengeItem(challenge: e))
                              .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) => AddChallengeScreen()),
          );
        },
        child: Container(
          width: 80,
          height: 38,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 20, color: Colors.white),
              SizedBox(width: 2),
              Text('만들기', style: mediumText(size: 12, color: Colors.white)),
              SizedBox(width: 7),
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectSort({required String text, bool last = false}) {
    return GestureDetector(
      onTap: () async {
        final navigator = Navigator.of(context);
        navigator.pop();
        challengeProvider.resetChallenges();
        challengeProvider.setSort(text);
        await challengeProvider.getChallengesData();
      },
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          border: last
              ? null
              : Border(
                  bottom: BorderSide(
                    width: 1.5,
                    color: Colors.grey.withValues(alpha: 0.5),
                  ),
                ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: challengeProvider.sortToText() == text
                ? pointColor.withValues(alpha: 0.5)
                : Colors.black,
          ),
        ),
      ),
    );
  }
}
