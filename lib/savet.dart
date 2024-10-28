import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SAVETIME extends StatelessWidget {
  const SAVETIME({super.key});

  @override
  Widget build(BuildContext context) {
    return SAVETIMEscreen();
  }
}

class SAVETIMEscreen extends StatefulWidget {
  const SAVETIMEscreen({super.key});

  @override
  State<SAVETIMEscreen> createState() => _SAVETIMEscreenState();
}

class _SAVETIMEscreenState extends State<SAVETIMEscreen> {
  static final _controller = TextEditingController();
  //String _messages="";
  List<int> _subjects = [0,0,0];
  int _selected=0;

  @override
  void initState() {
    super.initState();
    _loadSubject("subject");
  }

  Future<void> _loadSubject(String key) async {
    final pref = await SharedPreferences.getInstance();
    List<String>? stringList = pref.getStringList(key);
    if (stringList != null) {
      setState(() {
        _subjects = stringList.map((i) => int.parse(i)).toList();
      });
    }
  }

  void _saveSubject(String key, List<int> list) async {
    final pref = await SharedPreferences.getInstance();
    List<String> stringList = list.map((i) => i.toString()).toList();
    await pref.setStringList(key, stringList);
  }

  void _addSubject(int listnum, int minutes) {
    setState(() {
      _subjects[listnum] += minutes;
    });
    _saveSubject('subject', _subjects);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('どう？'),
      ),
      body: Column(
        children: [
          TextField(controller: _controller
          ),
          DropdownButton(
            onChanged: popupSelected,
            value: _selected,
            items: <DropdownMenuItem<int>>[
              const DropdownMenuItem(child: Text("japanese"),value: 0,),
              const DropdownMenuItem(child: Text('math'),value: 1,),
              const DropdownMenuItem(child: Text('english'),value: 2,)
              
            ],
          ),
          TextButton(onPressed: (){
            _addSubject(_selected, int.parse(_controller.text));
            setState(() {
              _controller.text="";
            });

          },
           child: Text("OK")),
           Text('${_subjects}')
   
        ],
      ),
    );
  }

  void popupSelected(int? value){
    setState(() {
      _selected = value ?? 0;
      
    });
  }
}
