// ignore_for_file: unused_local_variable, invalid_use_of_protected_member
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/notifier/to_donotifier.dart';
import 'package:to_do/task_page.dart';

import 'models/todo.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "Task": (context) => TaskPage(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<dynamic> showEditDialog(BuildContext ctx, Todo todoItem) {
      final edittextController = TextEditingController(text: todoItem.text);
      return showDialog(
          context: ctx,
          builder: (context) {
            return AlertDialog(
              content: TextField(
                controller: edittextController,
              ),
              actions: [
                TextButton(
                  child: Text("Cancle"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text("Save"),
                  onPressed: () {
                    ref.read(todoListProvider.notifier).editTodo(
                        id: "${todoItem.id}",
                        description: edittextController.text);
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    }

    final descController = TextEditingController();
    final todoList = ref.watch(todoListProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (BuildContext context, int index) {
                  final todoItem = todoList[index];
                  return Card(
                    child: ListTile(
                      title: Text("${todoItem.text}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => showEditDialog(context, todoItem),
                            icon: Icon(CupertinoIcons.pencil),
                          ),
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(todoListProvider.notifier)
                                  .removeTodo(id: "${todoItem.id}");
                            },
                            icon: Icon(CupertinoIcons.delete_simple),
                          )
                        ],
                      ),
                    ),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  );
                },
              ),
            ),
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "Task");
          // ref.read(todoListProvider.notifier).add(text: descController.text);
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
