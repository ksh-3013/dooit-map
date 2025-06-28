import 'package:capstone_project_2/common/colors.dart';
import 'package:capstone_project_2/presentantion/providers/community/post_provider.dart';
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
    return SafeArea(child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
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
            //티어
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  height: 23,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: litePointColor,
                  ),
                  child: Text(
                    provider.postData!.authorTier,
                    style: semiBoldText(size: 11, color: pointColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: greyColor,
                  ),
                ),
                SizedBox(width: 10,),
                Column(
                  children: [
                    Text(provider.postData!.authorName, style: mediumText(size: 14, color: Colors.black),)
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
