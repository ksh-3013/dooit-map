import 'package:capstone_project_2/common/colors.dart';
import 'package:capstone_project_2/common/fonts.dart';
import 'package:capstone_project_2/presentantion/providers/challenges/add_challenge_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'calendar_widget.dart';

class ChallengeInfoWidget extends StatefulWidget {
  const ChallengeInfoWidget({super.key, required this.provider});

  final AddChallengeProvider provider;

  @override
  State<ChallengeInfoWidget> createState() => _ChallengeInfoWidgetState();
}

class _ChallengeInfoWidgetState extends State<ChallengeInfoWidget> {
  void updateScreen() => setState(() {});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.provider.addListener(updateScreen);
      widget.provider.setMaxMinutes();
    });
  }

  @override
  void dispose() {
    widget.provider.removeListener(updateScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height:
            (MediaQuery.sizeOf(context).height) -
            (MediaQuery.paddingOf(context).top) -
            (MediaQuery.paddingOf(context).bottom) -
            100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.provider.challengeType,
                    style: semiBoldText(size: 25, color: pointColor),
                  ),
                  Text(
                    ' 챌린지를 선택했어요',
                    style: semiBoldText(size: 25, color: Colors.black),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 20),
                Text(
                  '언제 도전할까요?',
                  style: semiBoldText(size: 16, color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 10),
            // 챌린지 기간
            GestureDetector(
              onTap: () async {
                final result = await showDialog<List<DateTime>>(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState2) {
                        return Dialog(
                          insetPadding: EdgeInsets.zero,
                          child: CalendarWidget(
                            setState2: setState2,
                          ),
                        );
                      },
                    );
                  },
                );
                widget.provider.selectDate = true;
                print(result);
                widget.provider.setDate(result!);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: Color(0xFFF1E7DE),
                ),
                child: Row(
                  children: [
                    Text(
                      '${DateFormat('yyyy-MM-dd').format(widget.provider.start)} ~ ${DateFormat('yyyy-MM-dd').format(widget.provider.end)}',
                      style: semiBoldText(
                        size: 16,
                        color:
                            widget.provider.selectDate
                                ? Colors.black
                                : Color(0xFFA6A6A6),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.calendar_month_outlined,
                      size: 20,
                      color: Color(0xFFA6A6A6),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 20),
                Text(
                  '몇시간을 도전할까요?',
                  style: semiBoldText(size: 16, color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 10),
            // 운동 시간
            Row(
              children: [
                // 시간 입력
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 40,
                    onSelectedItemChanged: (value) {
                      print(value);
                      widget.provider.setHour(value);
                    },
                    children: [
                      for (
                        int i = 0;
                        i <=
                            (widget.provider.maxMinutes -
                                    widget.provider.minutes) ~/
                                60;
                        i++
                      )
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          child: Text(
                            '${i + 0}',
                            style: semiBoldText(size: 16, color: Colors.black),
                          ),
                        ),
                    ],
                  ),
                ),
                Text(' 시간', style: semiBoldText(size: 20, color: Colors.black)),
                SizedBox(width: 10),
                // 분 입력
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 40,
                    onSelectedItemChanged: (value) {
                      print(value);
                      widget.provider.setMinutes(value);
                    },
                    children: [
                      for (
                        int i = 0;
                        i <=
                            widget.provider.maxMinutes -
                                widget.provider.hour * 60;
                        i++
                      )
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          child: Text(
                            '${i + 0}',
                            style: semiBoldText(size: 16, color: Colors.black),
                          ),
                        ),
                    ],
                  ),
                ),
                Text(' 분', style: semiBoldText(size: 20, color: Colors.black)),
              ],
            ),

            SizedBox(height: 25),

            Expanded(
              child: _customTextField(
                title: '참가 포인트를 몇 개로 할까요?',
                controller: widget.provider.betPointController,
                keyboard: TextInputType.number,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () async {
                  final check = widget.provider.checkInfo();
                  if(check != "") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(check))
                    );
                    return;
                  }
                  widget.provider.changeStep(2);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 110,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: pointColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '다음',
                        style: semiBoldText(size: 16, color: Colors.white),
                      ),
                      Icon(Icons.arrow_forward, size: 25, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _customTextField({
    required String title,
    required TextEditingController controller,
    bool rows = false,
    TextInputType keyboard = TextInputType.text,
    String hint = '',
  }) {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Row(
            children: [
              SizedBox(width: 20),
              Text(title, style: semiBoldText(size: 16, color: Colors.black)),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(rows ? 30 : 200),
            color: Color(0xFFF1E7DE),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboard,
            style: semiBoldText(size: 16, color: Colors.black),
            maxLines: rows ? null : 1,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: semiBoldText(size: 16, color: Color(0xFFA6A6A6)),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
      ],
    );
  }
}
