import 'package:dooit/presentation/screens/challenge_screen.dart';
import 'package:dooit/presentation/screens/community_screen.dart';
import 'package:dooit/presentation/screens/home_screen.dart';
import 'package:dooit/presentation/screens/map_screen.dart';
import 'package:dooit/presentation/screens/my_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    CommunityScreen(),
    MapScreen(),
    ChallengeScreen(),
    MyPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedLabelStyle: TextStyle(fontSize: 15),
        unselectedLabelStyle: TextStyle(fontSize: 15),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/vectors/exercise.svg',
                color: _currentIndex == 0 ? Colors.black : Colors.grey,
                width: 25,
                height: 25,
              ),
            ),
            label: '헬스',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.comment_outlined),
            ),
            label: '두잇토크',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.location_on_outlined),
            ),
            label: '두잇맵',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.flag_outlined),
            ),
            label: '챌린지',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.person_outline),
            ),
            label: '마이',
          ),
        ],
      ),
    );
  }
}
