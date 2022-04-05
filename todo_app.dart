import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_todo/models/todo_model.dart';
import 'package:flutter_riverpod_todo/providers/all_providers.dart';
import 'package:flutter_riverpod_todo/widget/title_widget.dart';
import 'package:flutter_riverpod_todo/widget/todo_list_item.dart';
import 'package:flutter_riverpod_todo/widget/toolbar_widget.dart';
import 'package:uuid/uuid.dart';
import 'package:riverpod/riverpod.dart';

class TodoApp extends ConsumerWidget {
   TodoApp({Key? key}) : super(key: key);
  final newTodoController = TextEditingController();
 
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    var allTodos =  ref.watch(filterTodoList);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
        children:  [
         const TitleWidget(),
          TextField(
            controller: newTodoController,
            decoration: const  InputDecoration(
              labelText: 'Neler Yapacaksın Bugün ?'
            ),
            onSubmitted: (newTodo){
              ref.read(todoListProvider.notifier).addTodo(newTodo);
            },
          ),
          const SizedBox(height: 20,),
          const ToolBarWidget(),
           for (var i = 0; i < allTodos.length; i++) 
              Dismissible(key: ValueKey(allTodos[i].id),
                onDismissed: (_){
                  ref.read(todoListProvider.notifier).remove(allTodos[i]);
                },
                child: ProviderScope(
                  overrides: [
                    currentTodo.overrideWithValue(allTodos[i])
                  ],
                  child: TodoListItemWidget())),
          
          
        ],
      ),
    );
  }
}