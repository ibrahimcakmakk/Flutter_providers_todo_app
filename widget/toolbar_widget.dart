import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_todo/providers/all_providers.dart';

class ToolBarWidget extends ConsumerWidget {
  const ToolBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final onCompletedTodoCount = ref.watch(todoListProvider);
    final filter = ref.watch(todoListFilter);
     var _currentfilter = TodoListFilter.all;
  Color changeTextColor(TodoListFilter filt){
    return _currentfilter == filt ? Colors.orange : Colors.yellow;
  }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:  [
        Expanded(child: Text(onCompletedTodoCount == 0 ? ' Tüm Görevler Ok ' :
        ref.watch(todoListProvider.notifier)
        .onCompletedTodoCount().toString()+ 
        ' görev tamamlanmadı',
        overflow: TextOverflow.ellipsis ,)),
         Tooltip(
           message: 'All Todos',
           
           child: TextButton(style: TextButton.styleFrom(primary: changeTextColor(TodoListFilter.all)),
             onPressed: (){
             ref.read(todoListFilter.notifier).state=TodoListFilter.all;
           },
           child: const Text('All'),
           ),
         ),
         Tooltip(
           message: 'Only Uncompleted Todos',
           child: TextButton(style: TextButton.styleFrom(primary: changeTextColor(TodoListFilter.all)),
             onPressed: (){
             ref.read(todoListFilter.notifier).state=TodoListFilter.active;

           },
           child: const Text('Active'),
           ),
         ),
         Tooltip(
           message: 'Only Completed Todos',
           child: TextButton(style: TextButton.styleFrom(primary: changeTextColor(TodoListFilter.all)),
             onPressed: (){
             ref.read(todoListFilter.notifier).state=TodoListFilter.completed;

           },
           child: const Text('Complete'),
           ),
         )
      ],
    );
  }
}