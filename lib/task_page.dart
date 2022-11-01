import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:to_do/notifier/to_donotifier.dart';

class TaskPage extends HookConsumerWidget {
  TaskPage({Key? key}) : super(key: key);
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: invalid_use_of_protected_member

    return Scaffold(
      appBar: AppBar(
        title: Text("Task Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: TextFormField(
                controller: descController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Enter your task Here",
                    labelText: "Task"),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(todoListProvider.notifier).add(text: descController.text);
          Navigator.pop(context);
        },
        tooltip: 'Add',
        child: Icon(Icons.done_outline_rounded),
      ),
    );
  }
}
