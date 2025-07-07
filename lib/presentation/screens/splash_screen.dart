// lib/presentation/screens/splash_screen.dart
import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../data/repositories/auth_repository.dart';
import '../screens/main_screen.dart';
import '../screens/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _authRepository = authRepository; // 전역 인스턴스

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _boot());
  }

  Future<void> _boot() async {
    /// 저장된 카카오 토큰을 서버로 다시 전송
    final ok = await _authRepository.sendKakaoTokenToServer(context);

    if (!mounted) return; // 위젯이 이미 dipose 됐을 때 보호
    ok ? _goMain() : _goSignIn();
  }

  // ──────────────────────────────────────────── 네비게이션
  void _goMain() => Navigator.of(
    context,
  ).pushReplacement(MaterialPageRoute(builder: (_) => const MainScreen()));

  void _goSignIn() => Navigator.of(
    context,
  ).pushReplacement(MaterialPageRoute(builder: (_) => const SignInScreen()));

  // ──────────────────────────────────────────── UI
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Dooit',
              style: TextStyle(
                color: textColor,
                fontSize: 40,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
