import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';

class TaskTile extends StatefulWidget {
  final TaskModel task;

  const TaskTile({super.key, required this.task});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          widget.task.title,
          style: TextStyle(
            decoration: widget.task.isCompleted ? TextDecoration.lineThrough : null,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(widget.task.description),
        leading: Checkbox(
          value: widget.task.isCompleted,
          onChanged: (_) async {
            await context.read<TaskProvider>().toggleTaskStatus(widget.task.id);
          },
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () async {
            await context.read<TaskProvider>().deleteTask(widget.task.id);
          },
        ),
      ),
    );
  }
}
