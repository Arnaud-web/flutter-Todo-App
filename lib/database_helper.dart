import 'dart:async';
import 'package:app/models/task.dart';
import 'package:app/models/todo.dart';
import 'package:sqflite/sqlite_api.dart';
// import 'models/task.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
      onCreate: (db, version) async {
        await db.execute(
          " CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, description TEXT) ",
        );
        await db.execute(
          " CREATE TABLE todo (id INTEGER PRIMARY KEY,taskId INTEGER ,title TEXT, isDone INTEGER, prix INTEGER) ",
        );

        return db;
      },
      version: 1,
    );
  }

  Future<int> insertTask(Task task) async {
    int taskId = 0;
    Database _db = await database();
    await _db
        .insert('tasks', task.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      taskId = value;
    });
    return taskId;
  }

  Future<void> updateTaskTitle(int id, String title) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE tasks SET title = '$title' WHERE id  = '$id'");
  }

  Future<void> updateTaskDescription(int id, String description) async {
    Database _db = await database();
    await _db.rawUpdate(
        "UPDATE tasks SET description = '$description' WHERE id  = '$id'");
  }

  Future<void> insertTodo(Todo todo) async {
    Database _db = await database();
    await _db.insert('todo', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Task>> getTasks() async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap = await _db.rawQuery("SELECT * FROM tasks ORDER by id DESC");
    return List.generate(taskMap.length, (index) {
      return Task(
          id: taskMap[index]['id'],
          title: taskMap[index]['title'],
          description: taskMap[index]['description']);
    });
  }

  Future<List<Todo>> getTodo(int taskId) async {
    var _total = 0;
    Database _db = await database();
    List<Map<String, dynamic>> todoMap =
        await _db.rawQuery("SELECT * FROM todo WHERE taskId =$taskId");
    return List.generate(todoMap.length, (index) {
      _total = _total + todoMap[index]['prix'];
      return Todo(
          id: todoMap[index]['id'],
          taskId: todoMap[index]['taskId'],
          title: todoMap[index]['title'],
          prix: todoMap[index]['prix'],
          isDone: todoMap[index]['isDone']);

    });
  }

  Future<void> updateTodoDone(int id, int isDone) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE todo SET isDone = '$isDone' WHERE id  = '$id'");
  }
  Future<void> updateTodoPrix(int id, int prix) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE todo SET prix = '$prix' WHERE id  = '$id'");
  }
 
  Future<void> deleteTask(int id) async {
    Database _db = await database();
    await _db.rawDelete("DELETE FROM tasks  WHERE id  = '$id'");
    await _db.rawDelete("DELETE FROM todo  WHERE taskId  = '$id'");

  }
 

}


