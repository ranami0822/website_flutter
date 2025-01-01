import 'dart:async';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
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
  //音声
  late AudioPlayer _player;
  

  int _timer_text =0;
  Timer? _timer;
  bool isPaused = false;
  @override
  void initState(){
    super.initState();

    _setupSession();
  }

  Future<void> _setupSession() async{
    _player = AudioPlayer();
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());
    await _loadAudioFile();

  }

  Future<void> _loadAudioFile() async{
    try{
      await _player.setAsset('assets\bleep-41488.mp3');

    }catch(e){
      print(e);

    }
  }

  Future<void> _playSoundFile() async{
    if(_player.processingState==ProcessingState.completed){
      await _loadAudioFile();
    }

    await _player.setSpeed(1);
    await _player.play();
  }


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
        Text("${_timer_text~/60}min,${_timer_text%60}sec",style: TextStyle(fontSize: 32*2),),
        TextButton(onPressed: (){isPaused? pauseTime():resume();}, child: Text("${isPaused?"resume ":"REstart"}")),
        TextButton(onPressed: ()=>setUpTime(), child: Text("START"))
      ],),),
    );
    
  }
  void setUpTime(){
    setState(() {
      isPaused=false;
    });
    _timer_text=25;
    _timer?.cancel();
    
    _timer=Timer.periodic(
      Duration(seconds: 1), 
      (Timer time) async {
        if(_timer_text>0 && !isPaused)
        setState(() {
          _timer_text--;
        });
        else if(_timer_text==0 ){
          time.cancel();
          await _player.play();


          showDialog(
            context: context,
            builder: (BuildContext context)=>AlertDialog(
              title: Text("alert"),
              content: Text("消して"),
                actions: <Widget>[
                  TextButton(onPressed: ()=> Navigator.pop(context,"OK"), child: Text("OK"))
                ],
            )
          );
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