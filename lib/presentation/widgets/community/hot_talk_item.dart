import 'package:capstone_project_2/common/colors.dart';
import 'package:capstone_project_2/common/fonts.dart';
import 'package:capstone_project_2/data/models/post_model.dart';
import 'package:flutter/material.dart';

class HotTalkItem extends StatelessWidget {
  const HotTalkItem({super.key, required this.postData});

 final PostModel postData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        children: [
          // 뒷 배경
          Column(
            children: [
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(15),
                width: 180,
                height: 125,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: pointColor
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15,),
                    Text(
                      postData.title,
                      style: semiBoldText(size: 13, color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5,),
                    Text(
                      postData.content,
                      style: mediumText(size: 11, color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10,),
                    _iconAndData(text: postData.commentCount, icon: Icons.chat),
                  ],
                ),
              ),
            ],
          ),
          // 프로필
          Row(
            children: [
              SizedBox(width: 13,),
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          // 티어
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 7),
            height: 23,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              color: litePointColor,
            ),
            child: Text(postData.authorTier, style: semiBoldText(size: 11, color: pointColor),),
          ),
        ],
      ),
    );
  }

  Widget _iconAndData({required int text, required IconData icon}) {
    return SizedBox(
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.white.withOpacity(0.3),),
          SizedBox(width: 3,),
          Text('${text}', style: mediumText(size: 11, color: Colors.white),),
        ],
      ),
    );
  }

}
