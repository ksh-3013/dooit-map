import 'package:dooit/core/colors.dart';
import 'package:dooit/data/models/data.dart';
import 'package:dooit/data/repositories/alarm_repository.dart';
import 'package:dooit/data/repositories/user_repository.dart';
import 'package:dooit/presentation/providers/check_provider.dart';
import 'package:dooit/presentation/screens/alarm_screen.dart';
import 'package:dooit/presentation/screens/exercise_analysis_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../components/custom_swiper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// repositories & providers
  final alarmRepository = AlarmRepository();
  final checkProvider = CheckProvider();

  /// convenient getters with null‑safe fallbacks
  int get weekMinutes => data.weekStatTime ?? 0;
  int get avgMinutes  => data.weeklyDailyAverageWorkoutDuration ?? 0;
  int get maxMinutes  => data.weeklyMaxWorkoutDuration ?? 0;
  int get totalPoint  => data.totalPoint ?? 0;


  /// util
  Color getGradientColor(int duration, {int maxDuration = 7200}) {
    final ratio = (duration / maxDuration).clamp(0.0, 1.0);
    return Color.lerp(Colors.white, Colors.blue.shade800, ratio)!;
  }

  String formatMinutes(int minutes) {
    if (minutes == 0) return '0';
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    return '${hours}h ${mins.toString().padLeft(2, '0')}m';
  }

  String getWeeklyExerciseMessage(int minutes) {
    if (minutes <= 0) return '이번 주 운동 기록이 없어요 😫';
    if (minutes < 60) return '이번 주는 거의 안 움직였어요';
    if (minutes < 180) return '그래도 몸 좀 풀긴 했네요! 👍';
    if (minutes < 360) return '운동 습관 들이기 좋아요!';
    if (minutes < 600) return '와! 운동 루틴이 잡혀가고 있어요! 🔥';
    return '프로 운동러 멋져요~! 🏆';
  }

  @override
  void initState() {
    super.initState();
    // 비동기 호출만 시작하고, 값이 준비되면 provider/state 가 갱신되도록 둔다.
    alarmRepository.getAlarm();
  }

  @override
  Widget build(BuildContext context) {
    // weekStats를 안전하게 가져오기
    final List<Map<String, dynamic>> weekStats =
        data.weekStats ?? List.generate(7, (_) => {});

    return Scaffold(
      backgroundColor: const Color(0xffF6EFE9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            // 상단 헤더 --------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/home_screen_title.png',
                    width: 250,
                    height: 100,
                  ),
                  const Spacer(),
                  _pointBadge(),
                  const SizedBox(width: 10),
                  _alarmButton(context),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _timerArea(),
            const SizedBox(height: 25),
            _quickButtons(),
            const SizedBox(height: 25),
            _bannerSwiper(),
            const SizedBox(height: 20),
            _weeklySummary(context),
            const SizedBox(height: 30),
            _weeklyBarChart(weekStats),
            const SizedBox(height: 10),
            _weekdayLabels(weekStats),
            _dayNumbers(weekStats),
            const SizedBox(height: 20),
            _statCard(
              iconPath: 'assets/images/chart.png',
              label: '이번 주 평균 운동 시간',
              value: avgMinutes == 0 ? '운동 기록이 없어요' : formatMinutes(avgMinutes),
            ),
            const SizedBox(height: 10),
            _statCard(
              iconPath: 'assets/images/fire.png',
              label: '이번 주 최대 운동 시간',
              value: formatMinutes(maxMinutes),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // ------------------------- 위젯 조각들 -----------------------------
  Widget _pointBadge() => Container(
    width: 70,
    height: 35,
    decoration: BoxDecoration(
      color: const Color(0xffF1E7DE),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/glowing_star.png', width: 25, height: 25),
        const SizedBox(width: 5),
        Text(
          '$totalPoint',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            fontFamily: 'Pretendard',
          ),
        ),
        Text(
          '개',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );

  Widget _alarmButton(BuildContext context) => GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (c, a, s) => const AlarmScreen(),
          transitionsBuilder: (c, a, s, child) {
            const begin = Offset(1, 0);
            const end = Offset.zero;
            const curve = Curves.ease;
            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));
            return SlideTransition(position: a.drive(tween), child: child);
          },
        ),
      );
    },
    child: const Icon(Icons.notifications, color: Colors.grey, size: 30),
  );

  Widget _timerArea() => SizedBox(
    width: 350,
    height: 350,
    child: Stack(
      children: [
        Image.asset('assets/images/timer_bg.png', color: Colors.green),
        // TODO: 타이머 값 표시 예정
        const Center(child: SizedBox()),
      ],
    ),
  );

  Widget _quickButtons() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _roundedButton(
          label: '헬스장 찾기',
          icon: 'assets/images/pin.png',
          dark: true,
        ),
        const SizedBox(width: 10),
        _roundedButton(
          label: 'Check-in',
          icon: 'assets/images/biceps.png',
          dark: false,
        ),
      ],
    ),
  );

  Widget _roundedButton({
    required String label,
    required String icon,
    bool dark = true,
  }) => Container(
    width: 180,
    height: 65,
    decoration: BoxDecoration(
      color: dark ? Colors.black : Colors.grey.shade500,
      borderRadius: BorderRadius.circular(50),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(icon, width: 35, height: 35),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );

  Widget _bannerSwiper() => CustomSwiper(
    items: List.generate(
      5,
      (i) => Image.asset('assets/images/banner${i + 1}.png', fit: BoxFit.cover),
    ),
    height: 100,
    autoPlay: true,
    autoPlayInterval: const Duration(seconds: 5),
    onTap: (i) => handleTap(i),
  );

  Widget _weeklySummary(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '이번 주 운동 시간',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              formatMinutes(weekMinutes),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 43,
                fontFamily: 'HSSanTokki',
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              getWeeklyExerciseMessage(weekMinutes),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Column(
          children: [
            const SizedBox(height: 60),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a, s) => const ExerciseAnalysisScreen(),
                ),
              ),
              child: Container(
                width: 135,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      '운동 분석 보기',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_right, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _weeklyBarChart(List<Map<String, dynamic>> weekStats) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        final dayData = index < weekStats.length ? weekStats[index] : {};
        final duration = (dayData['duration'] ?? 0) as int;
        const maxHeight = 120.0;
        const maxDuration = 3600;
        final barHeight = ((duration / maxDuration) * maxHeight).clamp(
          0,
          maxHeight,
        );
        if (duration == 0) {
          return DottedBorder(
            options: const RoundedRectDottedBorderOptions(
              dashPattern: [7, 5],
              strokeWidth: 1.3,
              radius: Radius.circular(20),
              padding: EdgeInsets.zero,
            ),
            child: Container(
              width: 40,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        }
        return Container(
          width: 40,
          height: 140,
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Container(
            width: 40,
            height: 100,
            decoration: BoxDecoration(
              color: getGradientColor(duration),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }),
    ),
  );

  Widget _weekdayLabels(List<Map<String, dynamic>> weekStats) {
    const weekdayNames = ['월', '화', '수', '목', '금', '토', '일'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        final workDateStr = (index < weekStats.length)
            ? weekStats[index]['work_date'] as String?
            : null;
        if (workDateStr == null) return const Text('-');
        final workDate = DateTime.parse(workDateStr);
        final weekday = weekdayNames[workDate.weekday - 1];
        final isToday = workDateStr == data.daily;
        return Text(
          weekday,
          style: TextStyle(
            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            color: isToday ? Colors.black : Colors.grey,
          ),
        );
      }),
    );
  }

  Widget _dayNumbers(List<Map<String, dynamic>> weekStats) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        final dayData = index < weekStats.length ? weekStats[index] : {};
        final workDateStr = dayData['work_date'] as String?;
        if (workDateStr == null) return const Text('-');
        final workDate = DateTime.parse(workDateStr);
        final isToday = workDateStr == data.daily;
        return Text(
          '${workDate.day}',
          style: TextStyle(
            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            color: isToday ? Colors.black : Colors.grey,
          ),
        );
      }),
    ),
  );

  Widget _statCard({
    required String iconPath,
    required String label,
    required String value,
  }) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Image.asset(iconPath, width: 30, height: 30),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 15,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: Colors.grey,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 30),
        ],
      ),
    ),
  );

  // dummy handler (replace with url launch)
  void handleTap(int index) {}
}
