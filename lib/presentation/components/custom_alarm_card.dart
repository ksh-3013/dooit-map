import 'package:flutter/material.dart';
import '../../core/colors.dart';

class CustomAlarmCard extends StatefulWidget {
  final String iconPath;
  final String title;
  final String text1;
  final String? text2;
  final String date;
  bool isRead;

  CustomAlarmCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.text1,
    required this.isRead,
    this.text2,
    required this.date,
  });

  @override
  State<CustomAlarmCard> createState() => _CustomAlarmCardState();
}

class _CustomAlarmCardState extends State<CustomAlarmCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isRead = true;
        });
      },
      child: Container(
        width: double.infinity,
        height: 125,
        color: widget.isRead ? Colors.white : const Color(0xffF8F5FE),
        padding: const EdgeInsets.only(left: 20, top: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/${widget.iconPath}',
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 17,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${widget.text1}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${widget.text2}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.date,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontFamily: 'HSSanTokki',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
