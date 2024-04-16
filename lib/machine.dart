import 'package:flutter/material.dart';
import 'dart:async';

class TimerButton extends StatefulWidget {
  const TimerButton({super.key});

  @override
  TimerButtonState createState() => TimerButtonState();
}

class TimerButtonState extends State<TimerButton> {
  Timer? _pressedTimer;
  Timer? _notPressedTimer;
  int _pressedMilliseconds = 0;
  int _notPressedMilliseconds = 0;
  String _displayText = '';

  void _startPressedTimer() {
    _pressedTimer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _pressedMilliseconds += 10;
      });
    });
  }

  void _stopPressedTimer() {
    if (_pressedTimer != null) {
      _pressedTimer!.cancel();
      _pressedTimer = null;
    }
  }

  void _resetPressedTime() {
    setState(() {
      _pressedMilliseconds = 0;
    });
  }

  void _startNotPressedTimer() {
    _notPressedTimer =
        Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _notPressedMilliseconds += 10;
      });
    });
  }

  void _stopNotPressedTimer() {
    if (_notPressedTimer != null) {
      _notPressedTimer!.cancel();
      _notPressedTimer = null;
    }
  }

  void _resetNotPressedTime() {
    setState(() {
      _notPressedMilliseconds = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Morse Translator Machine'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Pressed Milliseconds: $_pressedMilliseconds',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Not Pressed Milliseconds: $_notPressedMilliseconds',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              _displayText,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTapDown: (details) {
                _startPressedTimer();
                _stopNotPressedTimer();
                if (_notPressedMilliseconds > 350 &&
                    _notPressedMilliseconds < 1000) {
                  setState(() {
                    _displayText += ' ';
                  });
                } else if (_notPressedMilliseconds >= 1000) {
                  setState(() {
                    _displayText += '/';
                  });
                }
                _resetNotPressedTime();
              },
              onTapUp: (details) {
                _stopPressedTimer();
                _startNotPressedTimer();
                if (_pressedMilliseconds < 200) {
                  setState(() {
                    _displayText += '.';
                  });
                } else {
                  setState(() {
                    _displayText += '-';
                  });
                }
                _resetPressedTime();
              },
              onTapCancel: () {
                _stopPressedTimer();
                _startNotPressedTimer();
                if (_pressedMilliseconds < 200) {
                  setState(() {
                    _displayText += '.';
                  });
                } else {
                  setState(() {
                    _displayText += '-';
                  });
                }
                _resetPressedTime();
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.blue,
                child: const Text(
                  'Press and Hold',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _stopPressedTimer();
    _stopNotPressedTimer();
    super.dispose();
  }
}
