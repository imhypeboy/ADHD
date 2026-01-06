/// 타이머 데이터 저장소 인터페이스
/// 로컬 저장소 (SharedPreferences/Isar) 구현 예정
abstract class TimerRepository {
  /// 타이머 설정 저장
  Future<void> saveTimerSettings({
    required Duration defaultDuration,
  });

  /// 타이머 설정 불러오기
  Future<Duration?> getDefaultDuration();

  /// 타이머 기록 저장
  Future<void> saveTimerRecord({
    required DateTime startTime,
    required DateTime endTime,
    required Duration duration,
  });

  /// 타이머 기록 불러오기
  Future<List<Map<String, dynamic>>> getTimerRecords();
}

/// 메모리 기반 임시 구현 (나중에 SharedPreferences/Isar로 교체)
class MemoryTimerRepository implements TimerRepository {
  Duration? _defaultDuration;
  final List<Map<String, dynamic>> _records = [];

  @override
  Future<void> saveTimerSettings({required Duration defaultDuration}) async {
    _defaultDuration = defaultDuration;
  }

  @override
  Future<Duration?> getDefaultDuration() async {
    return _defaultDuration;
  }

  @override
  Future<void> saveTimerRecord({
    required DateTime startTime,
    required DateTime endTime,
    required Duration duration,
  }) async {
    _records.add({
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'duration': duration.inMilliseconds,
    });
  }

  @override
  Future<List<Map<String, dynamic>>> getTimerRecords() async {
    return List.unmodifiable(_records);
  }
}

