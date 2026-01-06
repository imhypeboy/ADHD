import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/timer_state.dart';
import '../providers/timer_provider.dart';
import '../widgets/custom_timer_widget.dart';
import '../../../../core/utils/date_formatter.dart';

/// 타이머 메인 페이지
class TimerPage extends ConsumerStatefulWidget {
  const TimerPage({super.key});

  @override
  ConsumerState<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends ConsumerState<TimerPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // 60 FPS 보장을 위한 TickerProvider
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16), // ~60 FPS
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timerState = ref.watch(timerProvider);
    final timerNotifier = ref.read(timerProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 커스텀 타이머 위젯
              CustomTimerWidget(
                progress: timerState.progress,
                size: 300,
                strokeWidth: 16,
              ),
              
              const SizedBox(height: 48),
              
              // 남은 시간 표시
              Text(
                DateFormatter.formatDuration(timerState.remainingTime),
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 64,
                  fontWeight: FontWeight.w700,
                ),
              ),
              
              const SizedBox(height: 48),
              
              // 컨트롤 버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (timerState.status == TimerStatus.idle ||
                      timerState.status == TimerStatus.completed)
                    FilledButton.icon(
                      onPressed: () => timerNotifier.start(),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('시작'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                    )
                  else if (timerState.status == TimerStatus.running)
                    FilledButton.icon(
                      onPressed: () => timerNotifier.pause(),
                      icon: const Icon(Icons.pause),
                      label: const Text('일시정지'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                    )
                  else if (timerState.status == TimerStatus.paused)
                    FilledButton.icon(
                      onPressed: () => timerNotifier.resume(),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('재개'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                    ),
                  
                  if (timerState.status != TimerStatus.idle)
                    const SizedBox(width: 16),
                  
                  if (timerState.status != TimerStatus.idle)
                    OutlinedButton.icon(
                      onPressed: () => timerNotifier.reset(),
                      icon: const Icon(Icons.refresh),
                      label: const Text('리셋'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
