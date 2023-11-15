import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:th6_todolist/modal/items.dart';
import 'package:th6_todolist/modal/itr.dart';
import 'package:th6_todolist/widget/card_modal_bottom.dart';

import 'widget/card_body_widget.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
      ),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Interact itr = Interact();
  List<DataItems> items = [];

  void __handleAddTask(String name) {
    final newItem = DataItems(id: DateTime.now().toString(), name: name);
    setState(() {
      items.add(newItem);
      itr.writeTasks(items);
    });
  }

  void _handleDeleteTask(String id) {
    setState(() {
      items.removeWhere((item) => item.id == id);
      itr.writeTasks(items);
    });
  }

  @override
  void initState() {
    super.initState();
    loadTask();
  }

  void loadTask() async {
    List<DataItems> tasksList = await itr.readTasks();
    setState(() {
      items = tasksList;
    });
    if (kDebugMode) {
      print('loadTask ok');
    }
  }

  void addTask(String name) {
    DataItems item = DataItems(
      id: DateTime.now().toString(),
      name: name,
    );
    setState(() {
      items.add(item);
      itr.writeTasks(items);
      if (kDebugMode) {
        print('addTask ok');
      }
    });
  }

  void deleteTask(String id) {
    setState(() {
      items.removeWhere((item) => item.id == id);
      itr.writeTasks(items);
      if (kDebugMode) {
        print('deleteTask ok ${items.length}');
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('rebuild');
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'ToDoList',
            style: TextStyle(fontSize: 40),
          ),
          backgroundColor: Colors.amber,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: items
                .map((item) => CardBody(
                      index: items.indexOf(item),
                      item: item,
                      handleDelete: _handleDeleteTask,
                    ))
                .toList(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.grey,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              isScrollControlled: true,
              context: context,
              builder: (BuildContext content) {
                return ModalBottom(addTask: __handleAddTask);
              },
            );
          },
          child: const Icon(
            Icons.add,
            size: 40,
          ),
        ));
  }
}
