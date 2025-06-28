import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarProvider extends ChangeNotifier {

  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  bool choiceStartDay = false;

  DateTime? startDay;
  DateTime? lastDay;

  void daySelect(DateTime newSelectedDay, DateTime newFocusedDay) {
    if (!isSameDay(selectedDay, newSelectedDay)) {
      selectedDay = newSelectedDay;
      focusedDay = newFocusedDay;
      notifyListeners();
    }
  }

  void pageChange(DateTime newFocusedDay) {
    focusedDay = newFocusedDay;
  }

  void changeDay() {
    choiceStartDay = !choiceStartDay;
    notifyListeners();
  }

  void setStartDay() {
    startDay = selectedDay;
    notifyListeners();
  }

  void setLastDay() {
    if (startDay!.year < selectedDay.year ||
        (startDay!.year == selectedDay.year &&
            (startDay!.month < selectedDay.month ||
                (startDay!.month == selectedDay.month &&
                    startDay!.day <= selectedDay.day)))) {
      lastDay = selectedDay;
    } else {
      selectedDay = startDay!;
      changeDay();
    }
    notifyListeners();
  }

}