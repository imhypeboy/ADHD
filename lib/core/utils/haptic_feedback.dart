import 'package:flutter/services.dart';

/// 진동(Haptic) 피드백 유틸리티
class HapticFeedback {
  /// 가벼운 피드백
  static Future<void> light() async {
    await SystemChannels.platform.invokeMethod<void>(
      'HapticFeedback.vibrate',
      'HapticFeedbackType.lightImpact',
    );
  }

  /// 중간 피드백
  static Future<void> medium() async {
    await SystemChannels.platform.invokeMethod<void>(
      'HapticFeedback.vibrate',
      'HapticFeedbackType.mediumImpact',
    );
  }

  /// 강한 피드백
  static Future<void> heavy() async {
    await SystemChannels.platform.invokeMethod<void>(
      'HapticFeedback.vibrate',
      'HapticFeedbackType.heavyImpact',
    );
  }

  /// 선택 피드백
  static Future<void> selection() async {
    await SystemChannels.platform.invokeMethod<void>(
      'HapticFeedback.vibrate',
      'HapticFeedbackType.selectionClick',
    );
  }
}

