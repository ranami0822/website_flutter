import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("board"),),
      body: MessageBoard(),
      );
  }
}


class MessageBoard extends StatefulWidget {
  @override
  _MessageBoardState createState() => _MessageBoardState();
}

class _MessageBoardState extends State<MessageBoard> {
  List<String> _messages = [];
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _messages = prefs.getStringList('messages') ?? [];
    });
  }

  void _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('messages', _messages);
  }



  void _addMessage(String message) {
    setState(() {
      _messages.add(message);
      _controller.clear();
    });
    _saveMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                  onLongPress: () {
                    setState(() {
                      _messages.removeAt(index);
                      _saveMessages();
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'メッセージを入力'),
                    onSubmitted: (value) {
                      if(_controller.text.isNotEmpty){
                        _addMessage(_controller.text);
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _addMessage(_controller.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      );
    
  }
}