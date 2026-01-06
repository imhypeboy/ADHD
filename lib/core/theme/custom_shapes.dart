import 'package:flutter/material.dart';

/// 버튼, 카드 등의 커스텀 Shape 정의
/// MD3 Shape 시스템 확장
class CustomShapes {
  /// 둥근 모서리 버튼 Shape
  static ShapeBorder get roundedButton => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      );

  /// 더 둥근 모서리 버튼 Shape
  static ShapeBorder get roundedButtonLarge => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      );

  /// 카드 Shape
  static ShapeBorder get cardShape => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      );

  /// 작은 카드 Shape
  static ShapeBorder get cardShapeSmall => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      );

  /// 원형 버튼 Shape
  static ShapeBorder get circularButton => const CircleBorder();

  /// FAB Shape
  static ShapeBorder get fabShape => const CircleBorder();
}

