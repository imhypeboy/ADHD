import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/todo/presentation/pages/todo_list_page.dart';
import 'features/todo/presentation/widgets/confetti_animation.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus - ADHD 맞춤형 할 일 관리',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        // 세련된 Off-White 배경
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6200EE),
          primary: const Color(0xFF6200EE),
          secondary: const Color(0xFF03DAC6),
          surface: Colors.white,
        ),
      ),
      themeMode: ThemeMode.light, // 프리미엄 룩을 위해 라이트 모드 고정 (선택 사항)
      home: const TodoListPage(),
    );
  }
}
