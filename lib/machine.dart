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

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData(
            dialogBackgroundColor:
                Colors.white, // Set background color to white
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // Set button text color to black
              ),
            ),
          ),
          child: AlertDialog(
            title: const Center(child: Text("Timing meaning")),
            contentPadding: EdgeInsets.zero,
            content: const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Pressing for 0 - 200ms = dot",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    "Pressing for 200ms+ = stripe",
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Pausing for 0 - 350ms = word",
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Pausing for 350ms+ = space",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Center(child: Text("Close")),
              ),
            ],
          ),
        );
      },
    );
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
    _stopPressedTimer(); // Stop the pressed timer
    _stopNotPressedTimer(); // Stop the not pressed timer
    _resetPressedTime(); // Reset the pressed timer
    _resetNotPressedTime(); // Reset the not pressed timer
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
    _stopPressedTimer(); // Stop the pressed timer
    _stopNotPressedTimer(); // Stop the not pressed timer
    _resetPressedTime(); // Reset the pressed timer
    _resetNotPressedTime(); // Reset the not pressed timer
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
        backgroundColor: const Color.fromARGB(
            255, 20, 21, 22), // Set the background color to gray
        foregroundColor: Colors.white,
        title: const Text('Morse Translator Machine'),
        centerTitle: true, // Center the title text
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 10, right: 12, bottom: 10, left: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _displayText.isEmpty
                    ? "Start by tapping the machine below..."
                    : _displayText,
                style: TextStyle(
                  fontSize: 20,
                  color: _displayText.isEmpty
                      ? Colors.black.withOpacity(0.25)
                      : Colors.black,
                ),
              ),
            ),
          ),
          Row(
            // Wrap the button with Row
            mainAxisAlignment:
                MainAxisAlignment.end, // Align the button to the right
            children: [
              Padding(
                padding:
                    const EdgeInsets.all(8.0), // Add margin in all directions
                child: ElevatedButton(
                  onPressed: _isTranslated
                      ? clearTranslatedText
                      : translateMorseToText,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors
                        .black
                        .withOpacity(0.4)), // Set background color to red
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white), // Set text color to white
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(_isTranslated
                          ? Icons.clear
                          : Icons
                              .translate), // Different icons based on _isTranslated
                      const SizedBox(
                          width:
                              8), // Adjust the spacing between the icon and text
                      Text(_isTranslated ? 'Clear Text' : 'Translate Morse'),
                    ],
                  ),
                ),
              ),
            ],
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
                child: Padding(
                  padding: const EdgeInsets.all(
                      10), // Add padding of 10 from all sides
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _showHelpDialog(context);
                          },
                          child: Icon(
                            Icons.help_outline,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                        Text(
                          'Pressing: ${_pressedMilliseconds}ms',
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Pausing: ${_notPressedMilliseconds}ms',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
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
