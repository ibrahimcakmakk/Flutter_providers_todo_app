import 'package:flutter_riverpod_todo/models/todo_model.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';





class TodoListManager extends StateNotifier<List<TodoModel>>{
  TodoListManager([List<TodoModel>? initialTodos]) : super(initialTodos ?? []);

  void addTodo(String description){
    var yeniEklenecekTodo = TodoModel(const Uuid().v4(),  description);
    state = [...state, yeniEklenecekTodo];
    
  }

  void toggle(String id){
    state = [
      for(var todo in state)
        if(todo.id == id)
          TodoModel(
            todo.id,
            todo.description,
            completed: !todo.completed)
      else
        todo,  
    ];
  }

  void edit({required String id,required String newDescription}){
    state = [
      for(var todo in state)
        if(todo.id == id)
          TodoModel(todo.id, newDescription,completed: todo.completed)
        else
          todo    
    ];

  }

  void remove(TodoModel silinecekTodo){
    state = state.where((element) => element.id != silinecekTodo.id).toList();
  }

  int onCompletedTodoCount(){
    return state.where((element) => !element.completed).length;
  }

}