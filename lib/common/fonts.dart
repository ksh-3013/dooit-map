import 'package:flutter.material.dart';

TextStyle blackText({required double size, required Color color}) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w900,
    fontFamily: 'Pretendard',
    color: color,
  );
}

TextStyle semiBoldText({required double size, required Color color}) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w700,
    fontFamily: 'Pretendard',
    color: color,
  );
}

TextStyle mediumText({required double size, required Color color}) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w500,
    fontFamily: 'Pretendard',
    color: color,
    // height: 1.2,
  );
}