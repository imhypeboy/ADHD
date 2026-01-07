import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/todo_provider.dart';
import '../widgets/todo_card.dart';
import '../widgets/empty_state.dart';
import '../widgets/confetti_animation.dart';
import 'add_todo_dialog.dart';

class TodoListPage extends ConsumerStatefulWidget {
  const TodoListPage({super.key});

  @override
  ConsumerState<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends ConsumerState<TodoListPage> {
  final TextEditingController _quickAddController = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  bool _showConfetti = false;

  @override
  void dispose() {
    _quickAddController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoState = ref.watch(todoProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ConfettiWidget(
        trigger: _showConfetti,
        child: Stack(
          children: [
            // 1. 배경: Mesh Gradient
            _buildMeshGradient(),

            // 2. 메인 컨텐츠
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  Expanded(
                    child: todoState.isEmpty
                        ? const EmptyState()
                        : _buildTodoList(todoState),
                  ),
                  const SizedBox(height: 100), // 입력창 공간
                ],
              ),
            ),

            // 3. Floating Glass Input Bar
            _buildGlassInput(context, colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildMeshGradient() {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -100,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE1BEE7).withOpacity(0.5),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(color: Colors.transparent),
            ),
          ),
        ),
        Positioned(
          bottom: -100,
          left: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFB39DDB).withOpacity(0.4),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(color: Colors.transparent),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Today",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A1A1A),
              letterSpacing: -0.5,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined, size: 28),
            color: Colors.grey[800],
          ),
        ],
      ),
    );
  }

  Widget _buildTodoList(TodoListState state) {
    return ListView.builder(
      itemCount: state.activeTodos.length,
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemBuilder: (context, index) {
        final todo = state.activeTodos[index];
        return TodoCard(
          key: ValueKey(todo.id),
          todo: todo,
          onToggle: () => _toggleTodo(todo),
          onDelete: () => ref.read(todoProvider.notifier).deleteTodo(todo.id),
        );
      },
    );
  }

  void _toggleTodo(dynamic todo) {
    final wasCompleted = todo.isCompleted;
    ref.read(todoProvider.notifier).toggleTodo(todo.id);
    if (!wasCompleted) {
      setState(() => _showConfetti = true);
      Future.delayed(const Duration(milliseconds: 120), () {
        if (mounted) setState(() => _showConfetti = false);
      });
      HapticFeedback.heavyImpact();
    }
  }

  Widget _buildGlassInput(BuildContext context, ColorScheme colorScheme) {
    return Positioned(
      left: 20,
      right: 20,
      bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _quickAddController,
                    onSubmitted: (_) => _quickAdd(),
                    decoration: InputDecoration(
                      hintText: "내일 기억할 일이 있나요?",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _quickAdd,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.primary,
                    ),
                    child: const Icon(Icons.arrow_upward_rounded, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _quickAdd() {
    final text = _quickAddController.text.trim();
    if (text.isEmpty) return;
    ref.read(todoProvider.notifier).addTodo(text);
    _quickAddController.clear();
    HapticFeedback.lightImpact();
  }
}
