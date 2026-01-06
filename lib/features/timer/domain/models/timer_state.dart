/// 타이머 상태 모델
enum TimerStatus {
  idle,      // 대기 중
  running,   // 실행 중
  paused,    // 일시정지
  completed, // 완료
}

/// 타이머 상태 데이터
class TimerState {
  final TimerStatus status;
  final Duration remainingTime;
  final Duration totalDuration;

  const TimerState({
    required this.status,
    required this.remainingTime,
    required this.totalDuration,
  });

  TimerState copyWith({
    TimerStatus? status,
    Duration? remainingTime,
    Duration? totalDuration,
  }) {
    return TimerState(
      status: status ?? this.status,
      remainingTime: remainingTime ?? this.remainingTime,
      totalDuration: totalDuration ?? this.totalDuration,
    );
  }

  /// 진행률 (0.0 ~ 1.0)
  double get progress {
    if (totalDuration.inMilliseconds == 0) return 0.0;
    return 1.0 - (remainingTime.inMilliseconds / totalDuration.inMilliseconds);
  }

  /// 남은 시간이 0인지 확인
  bool get isCompleted => remainingTime.inMilliseconds <= 0;
}

