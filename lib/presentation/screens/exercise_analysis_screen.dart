import 'package:dooit/core/colors.dart';
import 'package:flutter/material.dart';

class ExerciseAnalysisScreen extends StatefulWidget {
  const ExerciseAnalysisScreen({super.key});

  @override
  State<ExerciseAnalysisScreen> createState() => _ExerciseAnalysisScreenState();
}

class _ExerciseAnalysisScreenState extends State<ExerciseAnalysisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.keyboard_arrow_left, size: 40),
                ),
                Spacer(),
                Text(
                  '운동 분석',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 30,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.keyboard_arrow_left,
                  size: 40,
                  color: Colors.transparent,
                ),
              ],
            ),
          ),
          Row(
            children: [],
          )
        ],
      ),
    );
  }
}
