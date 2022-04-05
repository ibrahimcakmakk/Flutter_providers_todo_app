import 'package:flutter_riverpod_todo/models/todo_model.dart';
import 'package:flutter_riverpod_todo/providers/todo_list_manager.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';


enum TodoListFilter{
  all, active, completed
}

final todoListFilter = StateProvider((ref) => TodoListFilter.all,);


final todoListProvider = StateNotifierProvider<TodoListManager,List<TodoModel>>(((ref) {
  return TodoListManager([
    TodoModel(Uuid().v4(), 'Spora git'),
    TodoModel(Uuid().v4(), 'Ders çalış'),
    TodoModel(Uuid().v4(), 'Alışveriş'),


  ]);
}));


final unCompletedTodoCount = Provider((ref) {
  final allTodo = ref.watch(todoListProvider);
  final count = allTodo.where((element) => !element.completed).length;
  return count;
},);

final filterTodoList = Provider<List<TodoModel>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todoList = ref.watch(todoListProvider);

  switch(filter){
    case TodoListFilter.all:
      return todoList;
    case TodoListFilter.completed:
       return todoList.where((element) => element.completed).toList();
    case TodoListFilter.active:
      return todoList.where((element) => !element.completed).toList();
  }
  
},);

final currentTodo = Provider<TodoModel>((ref) {
  throw UnimplementedError();
},);