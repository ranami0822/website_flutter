import 'package:flutter/material.dart';
import 'dart:async';
class MYTIME extends StatelessWidget {
  const MYTIME({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: TimerScreen(),);
  }
}
class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  static const maxSeconds = 25 * 60;  // 25 minutes in seconds
  int remainingSeconds = maxSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;

    return Scaffold(
      appBar: AppBar(
        title: Text('25-Minute Timer'),
      ),
      body: Center(
        child: Text(
          '$minutes:${seconds.toString().padLeft(2, '0')}',
          style: TextStyle(fontSize: 48),
        ),
      ),
    );
  }
}