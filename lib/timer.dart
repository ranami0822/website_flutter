import 'package:flutter/material.dart';
import 'package:cupertino_timer/cupertino_timer.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Timer"),),
      body: TimerScreenBody(),
    );
  }
}

class TimerScreenBody extends StatefulWidget {
  const TimerScreenBody({super.key});

  @override
  State<TimerScreenBody> createState() => _TimerScreenBodyState();
}

class _TimerScreenBodyState extends State<TimerScreenBody> with TickerProviderStateMixin{
  AnimationController? controller;
  @override

  Widget build(BuildContext context) {
    controller = AnimationController(vsync: this);
    return Center(
      child: Column(children: [
        Container(
          margin: EdgeInsets.all(20),
          width: 200,
          height: 200,
          child: CupertinoTimer(duration: Duration(minutes: 25),),

        ),
        
        Container(
          margin: EdgeInsets.all(20),
          width: 200,
          height: 200,
          child: CupertinoTimer(
            duration: Duration(minutes: 25),
            startOnInit: true,
            timeStyle: TextStyle(fontFamily: 'Avenir Next',fontWeight: FontWeight.bold),
            ringColor: Colors.blue,
            ringStroke: 25,
            controller: this.controller,
            ), 
        ),
        TextButton(onPressed: (){this.controller?.forward();}, child: Text("start")),
        TextButton(onPressed: (){this.controller?.stop();}, child: Text("pause")),
        TextButton(onPressed: (){this.controller?.reset();}, child: Text("reset")),
        

      ],),
    ) ;
  }
}