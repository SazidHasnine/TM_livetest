import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> _tasks = [];
  static const String _tasksKey = 'tasks_list';

  TaskProvider() {
    _loadTasks();
  }

  List<TaskModel> get tasks {
    return _tasks.toList();
  }

  int get totalTasks => _tasks.length;
  int get completedTasks => _tasks.where((task) => task.isCompleted).length;
  int get pendingTasks => _tasks.where((task) => !task.isCompleted).length;

  Future<void> _loadTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? tasksData = prefs.getString(_tasksKey);
      if (tasksData != null) {
        final List<dynamic> decodedData = json.decode(tasksData);
        _tasks = decodedData
            .map((item) => TaskModel.fromMap(Map<String, dynamic>.from(item)))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading tasks: $e');
    }
  }

  Future<void> _saveTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encodedData = json.encode(
        _tasks.map((task) => task.toMap()).toList(),
      );
      await prefs.setString(_tasksKey, encodedData);
    } catch (e) {
      debugPrint('Error saving tasks: $e');
    }
  }

  Future<void> addTask(String title, String description) async {
    final newTask = TaskModel(
      id: DateTime.now().toString(),
      title: title,
      description: description,
    );
    _tasks.add(newTask);
    notifyListeners();
    await _saveTasks();
  }

  Future<void> toggleTaskStatus(String id) async {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index].toggleCompleted();
      notifyListeners();
      await _saveTasks();
    }
  }

  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
    await _saveTasks();
  }
}
