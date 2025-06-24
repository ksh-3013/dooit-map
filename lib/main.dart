import 'package:dooit/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AuthRepository.initialize(appKey: '4c8659bc1a01179e07eeb8a65fa3e11a');
  KakaoSdk.init(nativeAppKey: 'b8f49d34a5c546840dc13c5053c57eab');
  KakaoSdk.init(javaScriptAppKey: '4c8659bc1a01179e07eeb8a65fa3e11a');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
