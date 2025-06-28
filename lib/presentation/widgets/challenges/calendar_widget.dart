import 'package:capstone_project_2/common/colors.dart';
import 'package:capstone_project_2/common/fonts.dart';
import 'package:capstone_project_2/presentantion/providers/challenges/add_challenge_provider.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../providers/challenges/calendar_provider.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key, required this.setState2});

  final void Function(void Function()) setState2;

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final CalendarProvider provider = CalendarProvider();

  void updateScreen() => widget.setState2(() {});

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
    return SizedBox(
      height: 500,
      width: MediaQuery.sizeOf(context).width * 0.9,
      child: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.utc(
              DateTime.now().year + 1,
              DateTime.now().month,
              DateTime.now().day,
            ),
            focusedDay: provider.focusedDay,
            calendarFormat: provider.calendarFormat,
            currentDay: provider.startDay ?? provider.selectedDay,
            locale: 'ko_KR',
            daysOfWeekHeight: 20,
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: litePointColor,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: pointColor,
                shape: BoxShape.circle,
              ),
            ),
            selectedDayPredicate: (day) {
              return isSameDay(provider.selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              provider.lastDay == null
                  ? provider.daySelect(selectedDay, focusedDay)
                  : null;
            },
            // 화면이 새로고침 되더라도 사용자가 이동한 달이 유지되도록 focusedDay를 그 달 1로 일단 지정함
            onPageChanged: (focusedDay) {
              provider.pageChange(focusedDay);
            },
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (provider.lastDay != null) {
                Navigator.pop(context, [provider.startDay!, provider.lastDay!]);
              } else {
                // if(widget.addProvider.challengeType == 'DAILY' && provider.startDay == null) {
                //   provider.setStartDay();
                //   print(provider.startDay);
                //   Navigator.pop(context, [provider.startDay!]);
                // }
                provider.choiceStartDay
                    ? provider.setLastDay()
                    : provider.setStartDay();
                provider.changeDay();
              }
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              width: MediaQuery.sizeOf(context).width * 0.9 - 40,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                color: pointColor,
              ),
              child: Text(
                provider.choiceStartDay ? '끝나는 날 정하기' : provider.lastDay != null ? '끝내기' : '시작하는 날 정하기',
                style: semiBoldText(size: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
