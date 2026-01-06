import 'package:flutter/material.dart';

/// Seed Color 기반 팔레트 정의
/// MD3 ColorScheme.fromSeed를 활용한 컬러 시스템
class ColorSchemes {
  // 시드 컬러: Deep Orange (0xFFFF5722) 또는 Teal (0xFF009688)
  // 여기서는 Deep Orange 사용 (변경 가능)
  static const Color seedColor = Color(0xFFFF5722);
  
  // Pure White / Pure Black 배경 (타이머가 돋보이도록)
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color pureBlack = Color(0xFF000000);

  /// Light Theme ColorScheme
  static ColorScheme get lightColorScheme {
    return ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    ).copyWith(
      // Surface Tones를 Pure White에 가깝게 조정
      surface: pureWhite,
      surfaceContainerHighest: pureWhite,
      background: pureWhite,
    );
  }

  /// Dark Theme ColorScheme
  static ColorScheme get darkColorScheme {
    return ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    ).copyWith(
      // Surface Tones를 Pure Black에 가깝게 조정
      surface: pureBlack,
      surfaceContainerHighest: pureBlack,
      background: pureBlack,
    );
  }
}

/// 커스텀 컬러 확장 (ThemeData extensions)
/// MD3 표준 스펙 외의 커스텀 속성 관리
@immutable
class AppColors extends ThemeExtension<AppColors> {
  final List<Color> timerGradientColors;
  final Color timerGlowColor;

  const AppColors({
    required this.timerGradientColors,
    required this.timerGlowColor,
  });

  @override
  AppColors copyWith({
    List<Color>? timerGradientColors,
    Color? timerGlowColor,
  }) {
    return AppColors(
      timerGradientColors: timerGradientColors ?? this.timerGradientColors,
      timerGlowColor: timerGlowColor ?? this.timerGlowColor,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      timerGradientColors: [
        Color.lerp(timerGradientColors[0], other.timerGradientColors[0], t)!,
        Color.lerp(timerGradientColors[1], other.timerGradientColors[1], t)!,
      ],
      timerGlowColor: Color.lerp(timerGlowColor, other.timerGlowColor, t)!,
    );
  }

  /// Theme에서 AppColors 확장 가져오기
  static AppColors of(BuildContext context) {
    return Theme.of(context).extension<AppColors>()!;
  }
}

