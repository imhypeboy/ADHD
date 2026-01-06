import 'package:flutter/material.dart';

/// "Magazine Style" 타이포그래피
/// Pretendard 폰트 기반, Editorial Look 연출
/// 타이포그래피의 대담함으로 '엣지'를 연출
TextTheme appTextTheme(ColorScheme colorScheme) {
  const String fontName = 'Pretendard';

  return TextTheme(
    // 거대한 헤드라인 (잡지 스타일)
    displayLarge: TextStyle(
      fontFamily: fontName,
      fontSize: 57,
      height: 1.1, // 타이트한 행간
      fontWeight: FontWeight.w800, // Extra Bold
      letterSpacing: -0.5, // 자간 좁힘
      color: colorScheme.onSurface,
    ),
    displayMedium: TextStyle(
      fontFamily: fontName,
      fontSize: 45,
      height: 1.16,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.5,
      color: colorScheme.onSurface,
    ),
    displaySmall: TextStyle(
      fontFamily: fontName,
      fontSize: 36,
      height: 1.22,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.5,
      color: colorScheme.onSurface,
    ),
    headlineLarge: TextStyle(
      fontFamily: fontName,
      fontSize: 32,
      height: 1.25,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.5,
      color: colorScheme.onSurface,
    ),
    headlineMedium: TextStyle(
      fontFamily: fontName,
      fontSize: 28,
      height: 1.29,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.25,
      color: colorScheme.onSurface,
    ),
    headlineSmall: TextStyle(
      fontFamily: fontName,
      fontSize: 24,
      height: 1.33,
      fontWeight: FontWeight.w700,
      letterSpacing: 0,
      color: colorScheme.onSurface,
    ),
    titleLarge: TextStyle(
      fontFamily: fontName,
      fontSize: 22,
      height: 1.27,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      color: colorScheme.onSurface,
    ),
    titleMedium: TextStyle(
      fontFamily: fontName,
      fontSize: 16,
      height: 1.5,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: colorScheme.onSurface,
    ),
    titleSmall: TextStyle(
      fontFamily: fontName,
      fontSize: 14,
      height: 1.43,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: colorScheme.onSurface,
    ),
    // 본문은 가독성 위주
    bodyLarge: TextStyle(
      fontFamily: fontName,
      fontSize: 16,
      height: 1.5,
      fontWeight: FontWeight.w400, // Regular
      color: colorScheme.onSurface,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontName,
      fontSize: 14,
      height: 1.43,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: colorScheme.onSurface,
    ),
    bodySmall: TextStyle(
      fontFamily: fontName,
      fontSize: 12,
      height: 1.33,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: colorScheme.onSurface,
    ),
    // 버튼 텍스트 등
    labelLarge: TextStyle(
      fontFamily: fontName,
      fontSize: 14,
      height: 1.43,
      fontWeight: FontWeight.w600, // SemiBold
      letterSpacing: 0.1,
      color: colorScheme.onSurface,
    ),
    labelMedium: TextStyle(
      fontFamily: fontName,
      fontSize: 12,
      height: 1.33,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
      color: colorScheme.onSurface,
    ),
    labelSmall: TextStyle(
      fontFamily: fontName,
      fontSize: 11,
      height: 1.45,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
      color: colorScheme.onSurface,
    ),
  );
}

