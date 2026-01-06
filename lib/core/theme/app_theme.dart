import 'package:flutter/material.dart';
/// MD3 + Deep Orange 기반의 심플한 MVP 테마
/// 우리의 시그니처 컬러와 타이포그래피만 강하게 적용
class AppTheme {
  // 우리의 시그니처 컬러 (Deep Orange)
  static const seedColor = Color(0xFFFF5722);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Pretendard', // 앱 전역 폰트 적용
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.light,
        // 배경을 완전한 흰색으로 (타이머 강조를 위해)
        surface: Colors.white,
        onSurface: Colors.black,
      ),
      // "잡지 스타일" 타이포그래피 오버라이딩 (MVP 버전)
      textTheme: const TextTheme(
        // 거대한 타이머 숫자용
        displayLarge: TextStyle(
          fontSize: 80,
          fontWeight: FontWeight.w700,
          height: 1.0,
          letterSpacing: -1.5,
        ),
        // 버튼 텍스트
        labelLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
