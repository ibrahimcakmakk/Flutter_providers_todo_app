import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_todo/models/todo_model.dart';
import 'package:flutter_riverpod_todo/providers/all_providers.dart';
class TodoListItemWidget extends ConsumerStatefulWidget {
  
   TodoListItemWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoListItemWidgetState();
}
class _TodoListItemWidgetState extends ConsumerState<TodoListItemWidget>{
 
 late FocusNode _textFocusMode;
 late TextEditingController _textController;
  bool _hasFocus = false;
  
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textFocusMode = FocusNode();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textFocusMode.dispose();
    _textController.dispose();
    super.dispose();
  }


 
  @override
  Widget build(BuildContext context) {
    final currentTodoItem = ref.watch(currentTodo);
    return Focus(
      onFocusChange: (isFocus)  {
        if (!isFocus) {
          setState((() => {
            _hasFocus = false
          }));
          ref.read(todoListProvider.notifier).edit(id: currentTodoItem.id, newDescription: _textController.text);
          }
      },
      child: ListTile(
        onTap: (){
          setState(() {
            _hasFocus = true;
            _textFocusMode.requestFocus();
            _textController.text = currentTodoItem.description;

          });
          
        },
        leading: Checkbox(
          value: currentTodoItem.completed,
          onChanged: (value){
            ref.read(todoListProvider.notifier).toggle(currentTodoItem.id);
          },
        ),
        title: _hasFocus ? TextField(
          focusNode: _textFocusMode,
          controller: _textController,) 
        : Text(currentTodoItem.description),
      ),
    );
  }
}

