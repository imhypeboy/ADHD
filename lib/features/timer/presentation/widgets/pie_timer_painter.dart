import 'dart:math';
import 'package:flutter/material.dart';

/// MVP용 커스텀 파이 타이머 페인터
/// 1. 배경 원
/// 2. 남은 시간 비율만큼 색으로 채운 파이
class PieTimerPainter extends CustomPainter {
  final double progress; // 1.0 (Full) -> 0.0 (Empty)
  final Color color;
  final Color backgroundColor;

  PieTimerPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    // 1. 배경 원 그리기
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, bgPaint);

    // 2. 남은 시간 파이(Pie) 그리기
    // -90도(12시 방향)부터 시작
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // 12시 방향
      2 * pi * progress, // 진행률만큼 부채꼴 그리기
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant PieTimerPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}

