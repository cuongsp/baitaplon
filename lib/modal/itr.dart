import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../modal/items.dart';

class Interact {
  Future<List<DataItems>> readTasks() async {
    List<DataItems> tasks = [];
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/task-list.json');
      if (await file.exists()) {
        String jsonString = await file.readAsString();
        if (jsonString.isEmpty) {
          return [];
        }
        List<dynamic> json = jsonDecode(jsonString);
        tasks = json.map((task) => DataItems.fromJson(task)).toList();
      } else {
        await file.create(recursive: true);
      }
      if (kDebugMode) {
        print('readTask ok');
      }
    } catch (ex) {
      if (kDebugMode) {
        print('Read error: $ex');
      }
    }
    return tasks;
  }

  Future<void> writeTasks(List<DataItems> tasks) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/task-list.json');

      final jsonString = jsonEncode(tasks);
      await file.writeAsString(jsonString);
      if (kDebugMode) {
        print('writeTask ok');
      }
    } catch (ex) {
      if (kDebugMode) {
        print('Write error: $ex');
      }
    }
  }
}
