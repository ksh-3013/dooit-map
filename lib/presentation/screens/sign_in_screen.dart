import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../data/repositories/auth_repository.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  AuthRepository authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              'Dooit',
              style: TextStyle(
                color: textColor,
                fontSize: 40,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w900,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 350,
                height: 55,
                decoration: BoxDecoration(
                  color: Color(0xff03C75B),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 2),
                      Text(
                        'N',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '네이버로 시작하기',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                authRepository.loginWithKakao(context);
              },
              child: Container(
                width: 350,
                height: 55,
                decoration: BoxDecoration(
                  color: Color(0xffFDE500),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/kakao.png',
                        width: 23,
                        height: 23,
                      ),
                      Spacer(),
                      Text(
                        '카카오로 시작하기',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      SizedBox(width: 15),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // authRepository.signInWithGoogle(context);
              },
              child: Container(
                width: 350,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xffD8D8D8)),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/google.png',
                        width: 23,
                        height: 23,
                      ),
                      Spacer(),
                      Text(
                        'Google로 시작하기',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 17,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      SizedBox(width: 15),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 60),
            Text('비회원 문의하기', style: TextStyle(color: Color(0xff606060))),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
