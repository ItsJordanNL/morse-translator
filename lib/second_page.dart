import 'package:flutter/material.dart';
import 'dart:async';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer Button Demo',
      home: TimerButton(),
    );
  }
}

class TimerButton extends StatefulWidget {
  @override
  _TimerButtonState createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
  Timer? _pressedTimer;
  Timer? _notPressedTimer;
  int _pressedMilliseconds = 0;
  int _notPressedMilliseconds = 0;
  String _displayText = '';

  void _startPressedTimer() {
    _pressedTimer = Timer.periodic(Duration(milliseconds: 10), (timer) {
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
    _notPressedTimer = Timer.periodic(Duration(milliseconds: 10), (timer) {
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
        title: Text('Timer Button'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Pressed Milliseconds: $_pressedMilliseconds',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Not Pressed Milliseconds: $_notPressedMilliseconds',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              _displayText,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTapDown: (details) {
                _startPressedTimer();
                _resetNotPressedTime();
                _stopNotPressedTimer();
              },
              onTapUp: (details) {
                _stopPressedTimer();
                _startNotPressedTimer();
                if (_pressedMilliseconds < 200) {
                  // Print dot
                  setState(() {
                    _displayText += '.';
                  });
                } else {
                  // Print stripe
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
                  // Print dot
                  setState(() {
                    _displayText += '.';
                  });
                } else {
                  // Print stripe
                  setState(() {
                    _displayText += '-';
                  });
                }
                _resetPressedTime();
              },
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.blue,
                child: Text(
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
