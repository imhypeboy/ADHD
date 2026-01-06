import 'package:flutter/material.dart';
import '../../features/timer/presentation/pages/timer_page.dart';

/// 간단한 라우터 (go_router 없이)
/// 필요시 go_router 패키지 추가 가능
class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/timer':
        return MaterialPageRoute(builder: (_) => const TimerPage());
      default:
        return MaterialPageRoute(builder: (_) => const TimerPage());
    }
  }
}
