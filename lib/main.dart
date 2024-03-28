import 'package:flutter/material.dart';

void main() {
  runApp(MorseCodeTranslator());
}

class MorseCodeTranslator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Morse Code Translator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TranslatorHomePage(),
    );
  }
}

class TranslatorHomePage extends StatefulWidget {
  @override
  _TranslatorHomePageState createState() => _TranslatorHomePageState();
}

class _TranslatorHomePageState extends State<TranslatorHomePage> {
  String _morseCode = '';
  String _translatedText = '';

  void _appendToMorseCode(String character) {
    setState(() {
      _morseCode += character;
    });
  }

  void _translateMorseCode() {
    setState(() {
      _translatedText = translateMorseToText(_morseCode);
      _morseCode = ''; // Clear Morse code after translation
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Morse Code Translator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Morse Code Input:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              _morseCode,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _appendToMorseCode('.'),
                  child: Text('.'),
                ),
                ElevatedButton(
                  onPressed: () => _appendToMorseCode('-'),
                  child: Text('-'),
                ),
                ElevatedButton(
                  onPressed: () => _appendToMorseCode(' '),
                  child: Text('Space'),
                ),
                ElevatedButton(
                  onPressed: () => _appendToMorseCode('/'),
                  child: Text('/'),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _translateMorseCode,
              child: Text('Translate'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Translated Text:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              _translatedText,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  String translateMorseToText(String morseCode) {
    Map<String, String> morseCodeMap = {
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

    List<String> morseWords = morseCode.split('/');
    String translatedText = '';

    for (String morseWord in morseWords) {
      List<String> morseCharacters = morseWord.trim().split(' ');
      for (String morseChar in morseCharacters) {
        if (morseCodeMap.containsKey(morseChar)) {
          translatedText += morseCodeMap[morseChar]!;
        }
      }
      translatedText += ' ';
    }

    return translatedText.trim();
  }
}

class MorseButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const MorseButton({
    required this.label,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}
