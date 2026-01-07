import 'dart:math' as math;
import 'package:flutter/material.dart';

/// 완료 시 Confetti 애니메이션
/// 도파민 보상을 즉각 제공
class ConfettiWidget extends StatefulWidget {
  final Widget child;
  final bool trigger;

  const ConfettiWidget({
    super.key,
    required this.child,
    required this.trigger,
  });

  @override
  State<ConfettiWidget> createState() => _ConfettiWidgetState();
}

class _ConfettiWidgetState extends State<ConfettiWidget>
    with TickerProviderStateMixin {
  final List<ConfettiParticle> _particles = [];
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void didUpdateWidget(ConfettiWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.trigger && !oldWidget.trigger) {
      _createParticles();
      _controller.forward(from: 0);
    }
  }

  void _createParticles() {
    _particles.clear();
    final random = math.Random();
    for (int i = 0; i < 50; i++) {
      _particles.add(ConfettiParticle(
        x: random.nextDouble(),
        y: random.nextDouble(),
        color: _getRandomColor(random),
        size: 8 + random.nextDouble() * 8,
        velocityX: (random.nextDouble() - 0.5) * 0.02,
        velocityY: -0.01 - random.nextDouble() * 0.02,
        rotation: random.nextDouble() * 2 * math.pi,
        rotationSpeed: (random.nextDouble() - 0.5) * 0.1,
      ));
    }
  }

  Color _getRandomColor(math.Random random) {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
      Colors.pink,
    ];
    return colors[random.nextInt(colors.length)];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: ConfettiPainter(
                particles: _particles,
                progress: _controller.value,
              ),
              size: MediaQuery.of(context).size,
            );
          },
        ),
      ],
    );
  }
}

class ConfettiParticle {
  double x;
  double y;
  final Color color;
  final double size;
  final double velocityX;
  final double velocityY;
  double rotation;
  final double rotationSpeed;

  ConfettiParticle({
    required this.x,
    required this.y,
    required this.color,
    required this.size,
    required this.velocityX,
    required this.velocityY,
    required this.rotation,
    required this.rotationSpeed,
  });

  void update() {
    x += velocityX;
    y += velocityY;
    rotation += rotationSpeed;
  }
}

class ConfettiPainter extends CustomPainter {
  final List<ConfettiParticle> particles;
  final double progress;

  ConfettiPainter({
    required this.particles,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      // 파티클 위치 업데이트
      final updatedParticle = ConfettiParticle(
        x: particle.x + particle.velocityX * progress,
        y: particle.y + particle.velocityY * progress + progress * progress * 0.5, // 중력 효과
        color: particle.color,
        size: particle.size,
        velocityX: particle.velocityX,
        velocityY: particle.velocityY,
        rotation: particle.rotation + particle.rotationSpeed * progress,
        rotationSpeed: particle.rotationSpeed,
      );

      final paint = Paint()..color = updatedParticle.color.withOpacity(1 - progress);
      final rect = Rect.fromCenter(
        center: Offset(updatedParticle.x * size.width, updatedParticle.y * size.height),
        width: updatedParticle.size,
        height: updatedParticle.size,
      );
      canvas.save();
      canvas.translate(rect.center.dx, rect.center.dy);
      canvas.rotate(updatedParticle.rotation);
      canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: rect.width, height: rect.height),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(ConfettiPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

