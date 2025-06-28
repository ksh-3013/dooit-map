import 'package:capstone_project_2/common/colors.dart';
import 'package:capstone_project_2/common/fonts.dart';
import 'package:capstone_project_2/data/models/post_model.dart';
import 'package:capstone_project_2/presentantion/screens/community/post_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.postData});

  final PostModel postData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(builder: (context) => PostScreen(postId: 13),));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      postData.authorName,
                      style: mediumText(size: 12, color: Colors.black),
                    ),
                    Text(
                      postData.createdAt,
                      style: mediumText(size: 10, color: greyColor),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
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
                    postData.authorTier,
                    style: semiBoldText(size: 11, color: pointColor),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    postData.title,
                    style: semiBoldText(size: 16, color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5,),
            SizedBox(
              width: double.infinity,
              child: Text(postData.content, style: mediumText(size: 12, color: Colors.black), overflow: TextOverflow.ellipsis, maxLines: 2,),
            ),
            SizedBox(height: 10,),
            _iconAndData(text: postData.commentCount, icon: Icons.chat),
            SizedBox(height: 10,),
            Container(
              width: double.infinity,
              height: 1,
              color: greyColor.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconAndData({required int text, required IconData icon}) {
    return SizedBox(
      child: Row(
        children: [
          Icon(icon, size: 18, color: greyColor,),
          SizedBox(width: 3,),
          Text('${text}', style: mediumText(size: 11, color: greyColor),),
        ],
      ),
    );
  }

}
