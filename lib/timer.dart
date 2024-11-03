import 'dart:async';

import 'package:flutter/material.dart';

class MYTIME extends StatelessWidget {
  const MYTIME({super.key});

  @override
  Widget build(BuildContext context) {
    return TimerBody();
  }
}

class TimerBody extends StatefulWidget {
  const TimerBody({super.key});

  @override
  State<TimerBody> createState() => _TimerBodyState();
}

class _TimerBodyState extends State<TimerBody> {
  int _timer_text =0;
  Timer? _timer;
  bool isPaused = false;

  @override
  void dispose(){
    _timer?.cancel();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("timer"),),
      body: Center(child: Column(children: [
        Text("${_timer_text~/60}min,${_timer_text%60}sec",style: TextStyle(fontSize: 32),),
        TextButton(onPressed: (){isPaused? pauseTime():resume();}, child: Text("${isPaused?"resume ":"start"}")),
        TextButton(onPressed: ()=>setUpTime(), child: Text("STSTS"))
      ],),),
    );
    
  }
  void setUpTime(){
    setState(() {
      isPaused=false;
    });
    _timer_text=60*25;
    _timer?.cancel();
    
    _timer=Timer.periodic(
      Duration(seconds: 1), 
      (Timer time){
        if(_timer_text>0 && !isPaused)
        setState(() {
          _timer_text--;
        });
        else if(_timer_text==0 ){
          time.cancel();
        }
        
      }
      );
  }

  void pauseTime(){
    setState(() {
      isPaused = false;
    });
  }

  void resume(){
    setState(() {
      isPaused = true;
    });
  }
}