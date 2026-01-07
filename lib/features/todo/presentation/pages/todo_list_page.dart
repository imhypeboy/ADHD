import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/todo_provider.dart';
import '../widgets/todo_card.dart';
import '../widgets/empty_state.dart';
import '../widgets/confetti_animation.dart';
import 'add_todo_dialog.dart';

/// 할 일 목록 페이지
/// ADHD 맞춤형 UI: Card UI, AnimatedList, Micro-Interaction
class TodoListPage extends ConsumerStatefulWidget {
  const TodoListPage({super.key});

  @override
  ConsumerState<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends ConsumerState<TodoListPage> {
  final TextEditingController _quickAddController = TextEditingController();
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
    final textTheme = Theme.of(context).textTheme;

    return ConfettiWidget(
      trigger: _showConfetti,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => _showInfoSnack('메뉴 준비 중입니다'),
              ),
              title: Text(
                '오늘의 할 일',
                style: textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              centerTitle: false,
              pinned: true,
              floating: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_active_outlined),
                  onPressed: () => _showInfoSnack('알림 설정을 준비 중입니다'),
                ),
              ],
            ),
            if (todoState.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyState(
                  headline: '완벽해요!',
                  subtitle: '휴식을 취하세요',
                  nudge: '모든 걸 끝냈어요. 내일 꼭 기억할 일이 떠오르나요?',
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.only(top: 8, bottom: 24),
                sliver: SliverList.builder(
                  itemCount: todoState.activeTodos.length,
                  itemBuilder: (context, index) {
                    final todo = todoState.activeTodos[index];
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: animation.drive(
                            Tween(begin: const Offset(0, 0.05), end: Offset.zero)
                                .chain(CurveTween(curve: Curves.easeOut)),
                          ),
                          child: child,
                        ),
                      ),
                      child: TodoCard(
                        key: ValueKey(todo.id),
                        todo: todo,
                        onToggle: () {
                          final wasCompleted = todo.isCompleted;
                          ref.read(todoProvider.notifier).toggleTodo(todo.id);

                          if (!wasCompleted) {
                            setState(() => _showConfetti = true);
                            Future.delayed(const Duration(milliseconds: 120), () {
                              if (mounted) setState(() => _showConfetti = false);
                            });
                            HapticFeedback.heavyImpact();
                          }
                        },
                        onDelete: () => _removeTodo(todo.id),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showAddTodoDialog(context),
          icon: const Icon(Icons.add),
          label: const Text('할 일 추가'),
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onPrimaryContainer,
          elevation: 4,
        ),
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _quickAddController,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _quickAdd(),
                  decoration: InputDecoration(
                    hintText: '바로 적어둘까요?',
                    filled: true,
                    fillColor: colorScheme.surfaceVariant.withOpacity(0.35),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              FilledButton.icon(
                onPressed: _quickAdd,
                icon: const Icon(Icons.send_rounded),
                label: const Text('추가'),
                style: FilledButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context) async {
    final result = await showDialog<Map<String, String?>>(
      context: context,
      builder: (context) => const AddTodoDialog(),
    );

    if (result != null && mounted) {
      _addTodo(
        title: result['title']!,
        description: result['description'],
      );
    }
  }

  void _removeTodo(String id) {
    ref.read(todoProvider.notifier).deleteTodo(id);
  }

  void _quickAdd() {
    final text = _quickAddController.text.trim();
    if (text.isEmpty || !mounted) return;
    _quickAddController.clear();
    _addTodo(title: text);
  }

  void _addTodo({required String title, String? description}) {
    ref.read(todoProvider.notifier).addTodo(title, description: description);
  }

  void _showInfoSnack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

