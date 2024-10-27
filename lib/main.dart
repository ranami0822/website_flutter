import 'package:flutter/material.dart';
import 'package:website_flutter/timer.dart';
import 'package:website_flutter/board.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "study" ,
      home: Scaffold(
        appBar: AppBar(title: Text("勉強tool"),),
        body: SelectPage(),
      ),
      
    );
  }
}

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  static var _index = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ListTile(
            leading: const Icon(Icons.timer,size: 32,),
            title: const Text("25分タイマー"),
            selected: _index==0,
            onTap:(){
              _index=0;
              taptile(0);
            },

          ),
          ListTile(
            leading: const Icon(Icons.list,size: 32,),
            title: const Text("TODOLIST"),
            selected: _index==0,
            onTap:(){
              _index=1;
              taptile(1);
            },

          )


      ],),

    );
  }
  void taptile(int num){
    const widgetlist = <Widget>[MYTIME(),BoardScreen()];
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>widgetlist[num]));
    });
  }
}

