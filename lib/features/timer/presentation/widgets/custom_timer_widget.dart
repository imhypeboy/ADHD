import 'package:flutter/material.dart';
import 'pie_timer_painter.dart';
import '../../../../core/theme/color_schemes.dart';

/// 커스텀 타이머 위젯
/// RepaintBoundary로 리페인팅 영역 최소화
/// 60 FPS 보장을 위한 최적화
class CustomTimerWidget extends StatelessWidget {
  final double progress; // 0.0 ~ 1.0
  final double size;
  final double strokeWidth;

  const CustomTimerWidget({
    super.key,
    required this.progress,
    this.size = 300.0,
    this.strokeWidth = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);

    return RepaintBoundary(
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: PieTimerPainter(
            progress: progress.clamp(0.0, 1.0),
            gradientColors: appColors.timerGradientColors,
            glowColor: appColors.timerGlowColor,
            strokeWidth: strokeWidth,
          ),
        ),
      ),
    );
  }
}
