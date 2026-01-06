import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 타이머 상태 데이터 모델
class TimerState {
  final int totalSeconds; // 전체 설정 시간 (예: 60분)
  final int remainingSeconds; // 남은 시간
  final bool isRunning;

  TimerState({
    required this.totalSeconds,
    required this.remainingSeconds,
    this.isRunning = false,
  });

  // 진행률 (0.0 ~ 1.0) - 파이 차트 그릴 때 사용
  double get progress => remainingSeconds / totalSeconds;

  TimerState copyWith({int? remainingSeconds, bool? isRunning}) {
    return TimerState(
      totalSeconds: totalSeconds,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isRunning: isRunning ?? this.isRunning,
    );
  }
}

// 상태 관리자 (Notifier)
class TimerNotifier extends StateNotifier<TimerState> {
  Timer? _timer;

  // 초기값: 60분 (3600초)
  TimerNotifier()
      : super(TimerState(totalSeconds: 3600, remainingSeconds: 3600));

  void start() {
    if (state.isRunning) return;
    state = state.copyWith(isRunning: true);

    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (state.remainingSeconds <= 0) {
        stop(); // 0초 되면 정지
      } else {
        // MVP: 1초씩 차감 (정밀도는 이후 개선)
        state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
      }
    });
  }

  void pause() {
    _timer?.cancel();
    state = state.copyWith(isRunning: false);
  }

  void reset() {
    pause();
    state = TimerState(totalSeconds: 3600, remainingSeconds: 3600);
  }

  void stop() {
    _timer?.cancel();
    state = state.copyWith(isRunning: false, remainingSeconds: 0);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, TimerState>((ref) {
  return TimerNotifier();
});

