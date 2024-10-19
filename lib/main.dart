import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter TODOリスト',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<TodoItem> _todos = [];
  TextEditingController _controller = TextEditingController();

  void _addTodo() {
    setState(() {
      String todo = _controller.text;
      if (todo.isNotEmpty) {
        _todos.add(TodoItem(title: todo));
        _controller.clear();
      }
    });
  }

  void _removeTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  void _toggleTodo(int index) {
    setState(() {
      _todos[index].isCompleted = !_todos[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODOリスト'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: '新しいタスクを入力',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _addTodo,
                  child: Text('追加'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: _todos[index].isCompleted,
                    onChanged: (_) => _toggleTodo(index),
                  ),
                  title: Text(
                    _todos[index].title,
                    style: TextStyle(
                      decoration: _todos[index].isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removeTodo(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TodoItem {
  String title;
  bool isCompleted;

  TodoItem({required this.title, this.isCompleted = false});
}
