import 'package:flutter/material.dart';

import '../../common/fonts.dart';
import '../providers/challenges/challenge_provider.dart';

class ChallengeTypeBox extends StatelessWidget {
  const ChallengeTypeBox({super.key, required this.type, required this.function, required this.selectType, required this.height});

  final String type;
  final String selectType;
  final VoidCallback function;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
          color: selectType == type
              ? Colors.black
              : Colors.white,
        ),
        child: Text(type, style: mediumText(
          size: height - 19,
          color: selectType == type
              ? Colors.white
              : Colors.black,
        ),),
      ),
    );
  }
}
