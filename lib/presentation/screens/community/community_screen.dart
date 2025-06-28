import 'package:capstone_project_2/common/colors.dart';
import 'package:capstone_project_2/data/models/post_model.dart';
import 'package:capstone_project_2/presentantion/providers/community/community_provider.dart';
import 'package:capstone_project_2/presentantion/screens/search_challenge_screen.dart';
import 'package:capstone_project_2/presentantion/widgets/communit/hot_talk_item.dart';
import 'package:capstone_project_2/presentantion/widgets/communit/post_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/fonts.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final CommunityProvider provider = CommunityProvider();

  void updateScreen() => setState(() {});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.addListener(updateScreen);
    });
  }

  @override
  void dispose() {
    provider.removeListener(updateScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6EFE9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 상단
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Text(
                    'HEATH TALK',
                    style: blackText(size: 30, color: Colors.black),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(builder: (context) => SearchScreen(searchTarget: '커뮤니티'),));
                    },
                    child: Icon(
                      Icons.search_rounded,
                      size: 30,
                      color: Color(0xFFA6A6A6),
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.notifications, color: Color(0xFFA6A6A6), size: 30),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  // 이용공지
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      color: Color(0xFFF1E7DE),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.notifications_active,
                          size: 20,
                          color: Color(0xFFA6A6A6),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '헬스토크 이용가이드',
                          style: mediumText(size: 12, color: Colors.black),
                        ),
                        Spacer(),
                        Container(
                          alignment: Alignment.center,
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 11,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        '지금 HOT TALK',
                        style: semiBoldText(size: 22, color: Colors.black),
                      ),
                      Image.asset('assets/images/Fire1.png', width: 30),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // hot talk
            SizedBox(
              height: 145,
              width: double.infinity,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 5),
                scrollDirection: Axis.horizontal,
                children: [
                  for(int i = 0; i < 10; i++)
                    HotTalkItem(postData: PostModel(
                        authorId: 13,
                        authorName: '변지우',
                        authorTier: '헬중수',
                        title: '회사가 운동을 방해합니다',
                        content: '회사 근처 헬스장에서 운동을 하는데 점심시간에 갔다가 온다고 하니까 해봤자 뭐 얼마나 달라진다고 운동하냐며 그 시간에 일이나 더 하립니다',
                        commentCount: 12,
                        createdAt: '2025-03-04',
                        id: 43,
                        updatedAt: null
                    ),),
                ],
              ),
            ),
            SizedBox(height: 32),

            // 게시글 목록
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: MediaQuery.sizeOf(context).height - 450,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              ),
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(context: context, builder: (context) {
                            return Container(
                              width: double.infinity,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 15,),
                                  Container(
                                    width: 50,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(200),
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  _selectSort(text: '최신순'),
                                  _selectSort(text: '리액션 많은 순'),
                                  _selectSort(text: '댓글 많은 순', last: true),
                                ],
                              ),
                            );
                          },);
                        },
                        child: Row(
                          children: [
                            Text(provider.sortToText(), style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),),
                            Icon(Icons.arrow_drop_down, size: 20, color: Colors.black,),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  for(int i = 0; i < 10; i++)
                    PostItem(
                      postData: PostModel(
                        authorId: 13,
                        authorName: '변지우',
                        authorTier: '헬중수',
                        title: '가보입시더',
                        content: '그래서 제가요 진짜 그랬는데 너무 그래서 너무 그거 해버렸어요 진짜 우짜죠 진짜 진짜로 좀 많이 심각심각한 느낌인데',
                        commentCount: 12,
                        createdAt: '2025-03-04',
                        id: 43,
                        updatedAt: null
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectSort({required String text, bool last = false}) {
    return GestureDetector(
      onTap: () async {
        print(text);
        final navigator = Navigator.of(context);
        setState(() {

        });
        // challengeProvider.resetChallenges();
        provider.setSort(text);
        // await challengeProvider.getChallengesData();
        navigator.pop();
      },
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            border: last ? null : Border(bottom: BorderSide(width: 1.5, color: Colors.grey.withValues(alpha: 0.5)))
        ),
        child: Text(text, style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: provider.sortToText() == text ? pointColor.withValues(alpha: 0.5) : Colors.black,
        ),),
      ),
    );
  }

}
