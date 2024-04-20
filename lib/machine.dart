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
  bool _isTranslated = false;
  bool _isInputEnabled = true;
  String _backgroundImage = "assets/background_unpressed.jpg";

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

  void translateMorseToText() {
    // Define your Morse to text translation logic here
    // For simplicity, let's assume a mapping of Morse code to text
    final morseToText = {
      '.-': 'A',
      '-...': 'B',
      '-.-.': 'C',
      '-..': 'D',
      '.': 'E',
      '..-.': 'F',
      '--.': 'G',
      '....': 'H',
      '..': 'I',
      '.---': 'J',
      '-.-': 'K',
      '.-..': 'L',
      '--': 'M',
      '-.': 'N',
      '---': 'O',
      '.--.': 'P',
      '--.-': 'Q',
      '.-.': 'R',
      '...': 'S',
      '-': 'T',
      '..-': 'U',
      '...-': 'V',
      '.--': 'W',
      '-..-': 'X',
      '-.--': 'Y',
      '--..': 'Z',
      '.----': '1',
      '..---': '2',
      '...--': '3',
      '....-': '4',
      '.....': '5',
      '-....': '6',
      '--...': '7',
      '---..': '8',
      '----.': '9',
      '-----': '0',
      '/': ' ',
    };

    final morseWords = _displayText.trim().split('/');
    final translatedWords = morseWords.map((word) {
      final morseChars = word.split(' ');
      final translatedChars = morseChars.map((char) {
        return morseToText[char] ?? '';
      });
      return translatedChars.join();
    });
    setState(() {
      _displayText = translatedWords.join(' ');
      _isTranslated = true;
      _isInputEnabled = false; // Disable input during translation
    });
  }

  void clearTranslatedText() {
    setState(() {
      _displayText = '';
      _isTranslated = false;
      _isInputEnabled = true; // Enable input after clearing text
    });
  }

  void _changeBackgroundImage(bool pressed) {
    setState(() {
      _backgroundImage = pressed
          ? "assets/background_pressed.jpg"
          : "assets/background_unpressed.jpg";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Morse Translator Machine'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, right: 12, bottom: 10, left: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _displayText.isEmpty
                    ? "Start by tapping the machine below..."
                    : _displayText,
                style: TextStyle(
                  fontSize: 20,
                  color: _displayText.isEmpty ? Colors.black.withOpacity(0.25) : Colors.black,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed:
                  _isTranslated ? clearTranslatedText : translateMorseToText,
              child: Text(
                  _isTranslated ? 'Clear Text' : 'Translate Morse to Text'),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTapDown: _isInputEnabled
                  ? (details) {
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
                      _changeBackgroundImage(true);
                    }
                  : null,
              onTapUp: _isInputEnabled
                  ? (details) {
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
                      _changeBackgroundImage(false);
                    }
                  : null,
              onTapCancel: _isInputEnabled
                  ? () {
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
                      _changeBackgroundImage(false);
                    }
                  : null,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_backgroundImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
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
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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
