import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../domain/models/todo_item.dart';

/// 할 일 카드 위젯
/// 명확한 경계를 가진 카드 형태로 시각적 피로 감소
class TodoCard extends StatelessWidget {
  final TodoItem todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback? onTap;

  const TodoCard({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: todo.isCompleted ? 1 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // 체크박스
              Checkbox(
                value: todo.isCompleted,
                onChanged: (_) {
                  // Haptic Feedback
                  HapticFeedback.mediumImpact();
                  onToggle();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 12),
              // 할 일 내용
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        decoration: todo.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                        color: todo.isCompleted
                            ? colorScheme.onSurface.withOpacity(0.5)
                            : colorScheme.onSurface,
                      ),
                    ),
                    if (todo.description != null && todo.description!.isNotEmpty)
                      const SizedBox(height: 4),
                    if (todo.description != null && todo.description!.isNotEmpty)
                      Text(
                        todo.description!,
                        style: TextStyle(
                          fontSize: 14,
                          color: colorScheme.onSurface.withOpacity(0.6),
                          decoration: todo.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                  ],
                ),
              ),
              // 삭제 버튼
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: onDelete,
                color: colorScheme.error,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

