import 'package:flutter/material.dart';

void main() {
  runApp(const TimerApp());
}

class TimerApp extends StatelessWidget {
  const TimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TimerHomePage());
  }
}

class TimerHomePage extends StatefulWidget {
  const TimerHomePage({super.key});

  @override
  State<TimerHomePage> createState() => _TimerHomePageState();
}

class _TimerHomePageState extends State<TimerHomePage> {
  int _timeLeft = 10; // countdown from 10 seconds
  bool _isCounting = false;

  void _startTimer() {
    if (_isCounting) return;

    setState(() {
      _isCounting = true;
      _timeLeft = 10; // reset to 10 on every start
    });

    _countDown();
  }

  void _countDown() {
    if (_timeLeft > 0) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _timeLeft--;
        });
        _countDown(); // call again until _timeLeft is 0
      });
    } else {
      setState(() {
        _isCounting = false; // reset when done
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Timer App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_timeLeft.toString(), style: const TextStyle(fontSize: 60)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _startTimer,
              child: const Text("Start Timer"),
            ),
          ],
        ),
      ),
    );
  }
}
