import 'package:dooit/common/colors.dart';
import 'package:dooit/presentation/providers/community/post_provider.dart';
import 'package:flutter/material.dart';
import '../../../common/fonts.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key, required this.postId});

  final int postId;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final PostProvider provider = PostProvider();
  void updateScreen() => setState(() {});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.addListener(updateScreen);
      provider.getPostData();
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
      body: provider.postData == null
          ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Text('게시글을 불러오는 중 입니다.'),
              ],
            ),
          )
          : SingleChildScrollView(
        child: Column(
          children: [
            // 게시글 파트
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 상단
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.arrow_back_ios, size: 25, color: Colors.black),
                          ),
                          Spacer(),
                          Icon(Icons.more_vert, size: 25, color: Colors.black,),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text(provider.postData!.title, style: semiBoldText(size: 30, color: Colors.black),),
                    ],
                  ),
                  SizedBox(height: 15,),
                  // 이름
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: greyColor,
                        ),
                      ),
                      SizedBox(width: 10,),
                      // 정보
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //티어
                          Row(
                            children: [
                              Text(provider.postData!.authorName, style: mediumText(size: 12, color: Colors.black),),
                              SizedBox(width: 5,),
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                height: 16,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200),
                                  color: litePointColor,
                                ),
                                child: Text(
                                  provider.postData!.authorTier,
                                  style: semiBoldText(size: 8, color: pointColor),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2,),
                          Text(provider.postData!.createdAt, style: mediumText(size: 12, color: greyColor),),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text(provider.postData!.content, style: regularText(size: 14, color: Colors.black),),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              color: greyColor.withValues(alpha: 0.2),
              width: double.infinity,
              height: 15,
            ),
            //댓글

          ],
        ),
      ),
    );
  }
}
