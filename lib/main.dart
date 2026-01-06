import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/timer/presentation/widgets/pie_timer_painter.dart';
import 'features/timer/presentation/providers/timer_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus MVP',
      theme: AppTheme.lightTheme,
      home: const TimerPage(),
    );
  }
}

class TimerPage extends ConsumerWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. 타이머 영역 (Visual Hook)
            Expanded(
              flex: 3,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CustomPaint(
                      painter: PieTimerPainter(
                        progress: timerState.progress,
                        color: colorScheme.primary,
                        backgroundColor: colorScheme.surface,
                      ),
                      child: Center(
                        child: Text(
                          '${(timerState.remainingSeconds / 60).ceil()}',
                          style: textTheme.displayLarge?.copyWith(
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: const Offset(0, 2),
                                blurRadius: 4,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 2. 컨트롤 영역
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () =>
                        ref.read(timerProvider.notifier).reset(),
                    icon: const Icon(Icons.refresh),
                    iconSize: 32,
                  ),
                  FloatingActionButton.large(
                    onPressed: timerState.isRunning
                        ? () => ref.read(timerProvider.notifier).pause()
                        : () => ref.read(timerProvider.notifier).start(),
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    child: Icon(
                      timerState.isRunning
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 48,
                    ),
                  ),
                  const IconButton(
                    onPressed: null,
                    icon: Icon(Icons.settings),
                    iconSize: 32,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
