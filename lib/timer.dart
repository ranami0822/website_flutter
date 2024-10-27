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


class _TimerScreenBodyState extends State<TimerScreenBody> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(minutes: 25));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            width: 200,
            height: 200,
            child: CupertinoTimer(duration: const Duration(minutes: 25)),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            width: 200,
            height: 200,
            child: CupertinoTimer(
              duration: const Duration(minutes: 25),
              startOnInit: true,
              timeStyle: const TextStyle(
                fontFamily: 'Avenir Next',
                fontWeight: FontWeight.bold,
              ),
              ringColor: Colors.blue,
              ringStroke: 25,
              controller: controller,
            ),
          ),
          TextButton(
            onPressed: () {
              controller.forward();
            },
            child: const Text("start"),
          ),
          TextButton(
            onPressed: () {
              controller.stop();
            },
            child: const Text("pause"),
          ),
          TextButton(
            onPressed: () {
              controller.reset();
            },
            child: const Text("reset"),
          ),
        ],
      ),
    );
  }
}
