import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Morse Code Translator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MorseTranslator(),
    );
  }
}

class MorseTranslator extends StatefulWidget {
  @override
  _MorseTranslatorState createState() => _MorseTranslatorState();
}

class _MorseTranslatorState extends State<MorseTranslator> {
  String _morseCode = '';
  String _translation = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Morse Code Translator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_morseCode',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MorseButton(
                  text: '.',
                  onPressed: () {
                    setState(() {
                      _morseCode += '.';
                    });
                  },
                ),
                MorseButton(
                  text: '-',
                  onPressed: () {
                    setState(() {
                      _morseCode += '-';
                    });
                  },
                ),
                MorseButton(
                  text: ' ',
                  onPressed: () {
                    setState(() {
                      _morseCode += ' ';
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _translation = translateMorseToText(_morseCode);
                });
              },
              child: Text('Translate'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Translation: $_translation',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }

  String translateMorseToText(String morseCode) {
    Map<String, String> morseToText = {
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
      '.-.-.-': '.',
      '--..--': ',',
      '..--..': '?',
      '.----.': "'",
      '-.-.--': '!',
      '-..-.': '/',
      '-.--.': '(',
      '-.--.-': ')',
      '.-...': '&',
      '---...': ':',
      '-.-.-.': ';',
      '-...-': '=',
      '.-.-.': '+',
      '-....-': '-',
      '..--.-': '_',
      '.-..-.': '"',
      '...-..-': '\$',
      '.--.-.': '@',
      '': ' ', // space
    };

    List<String> words = morseCode.split(' ');
    String translation = '';
    for (String word in words) {
      if (morseToText.containsKey(word)) {
        translation += morseToText[word]!;
      } else {
        translation += '???'; // handle unrecognized Morse code characters
      }
    }
    return translation;
  }
}

class MorseButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MorseButton({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}
