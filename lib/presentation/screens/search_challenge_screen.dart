import 'package:capstone_project_2/common/colors.dart';
import 'package:capstone_project_2/common/fonts.dart';
import 'package:capstone_project_2/presentantion/providers/search_challenge_provider.dart';
import 'package:capstone_project_2/presentantion/screens/challenges/add_challenge_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/challenges/challenge_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.searchTarget});

  final String searchTarget;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final SearchChallengeProvider provider = SearchChallengeProvider();
  void updateScreen() => setState(() {});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.addListener(updateScreen);
      provider.setTexts(widget.searchTarget);
      provider.addList(widget.searchTarget);
    });
  }

  @override
  void dispose() {
    provider.removeListener(updateScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // 검색어 입력
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back_ios, size: 25, color: Colors.black,),
                ),
                Expanded(child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      color: greyColor.withOpacity(0.2)
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search_rounded, size: 25, color: Colors.black,),
                      SizedBox(width: 5,),
                      Expanded(child: TextField(
                        controller: provider.keywordController,
                        textInputAction: TextInputAction.search,
                        style: semiBoldText(size: 16, color: Colors.black),
                        decoration: InputDecoration(
                            hintText: provider.searchHintText,
                            hintStyle: semiBoldText(size: 16, color: greyColor),
                            border: InputBorder.none
                        ),
                        onSubmitted: (value) {
                          provider.getData(widget.searchTarget);
                        },
                        onTap: () {
                          if(provider.challenges.isNotEmpty) {
                            provider.resetKeyword();
                          };
                          provider.resetList(widget.searchTarget);
                        },
                      )),
                      SizedBox(width: 5,),
                      GestureDetector(
                        onTap: () {
                          provider.resetKeyword();
                          provider.resetList(widget.searchTarget);
                        },
                        child: Icon(Icons.cancel, size: 25, color: greyColor,),
                      ),
                    ],
                  ),
                )),
              ],
            ),
            SizedBox(height: 20,),
            provider.challengesData == null
                ? provider.keywordController.text.isEmpty ? SizedBox.shrink() : Text('검색 결과를 불러오는 중 입니다.')
                : provider.challengesData!.total_elements == 0
                    // 챌린지 겁색 안된 경우
                  ? Expanded(
                    child: Column(
                        children: [
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text('${provider.challengesData!.total_elements}개의 검색결과', style: mediumText(size: 12, color: greyColor),),
                          ),
                          Spacer(),
                          Text('\'${provider.keywordController.text}\' ${provider.nothingText}',
                            style: mediumText(
                                size: 14, color: greyColor), textAlign: TextAlign.center,),
                          SizedBox(height: 20,),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(CupertinoPageRoute(builder: (context) => AddChallengeScreen(),));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 130,
                              height: 60,
                              decoration: BoxDecoration(
                                color: pointColor,
                                borderRadius: BorderRadius.circular(200),
                              ),
                              child: Text(
                                provider.buttonText,
                                style: semiBoldText(size: 16, color: Colors.white),
                              ),
                            ),
                          ),
                          Spacer(),
                                  ],
                                ),
                  )
                    // 챌린지 검색 된 경우
                  : SingleChildScrollView(
            controller: provider.scrollController,
            child: Column(
              children: provider.challenges.map((e) => ChallengeItem(challenge: e)).toList(),),
            ),
          ],
        ),
      ),
    ));
  }
}
