import 'package:flutter/material.dart';
import 'machine.dart'; // Import the second page file

void main() {
  runApp(const MorseCodeTranslator());
}

class MorseCodeTranslator extends StatelessWidget {
  const MorseCodeTranslator({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Morse Code Translator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: const MorseCodeHomePage(),
    );
  }
}

class MorseCodeHomePage extends StatefulWidget {
  const MorseCodeHomePage({super.key});
  @override
  MorseCodeHomePageState createState() => MorseCodeHomePageState();
}

class MorseCodeHomePageState extends State<MorseCodeHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const TranslatorHomePage(),
    const TimerButton(), // Add SecondPage to the list of pages
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(
            255, 20, 21, 22), // Set background color to red
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.devices),
            label: 'Computer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.touch_app),
            label: 'Machine',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white, // Set color for active icon
        unselectedItemColor:
            Colors.white.withOpacity(0.6), // Set color for inactive icon
        onTap: _onItemTapped,
      ),
    );
  }
}

class TranslatorHomePage extends StatefulWidget {
  const TranslatorHomePage({super.key});
  @override
  TranslatorHomePageState createState() => TranslatorHomePageState();
}

class TranslatorHomePageState extends State<TranslatorHomePage> {
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
        backgroundColor: const Color.fromARGB(
            255, 20, 21, 22), // Set the background color to gray
        foregroundColor: Colors.white,
        title: const Text('Morse Translator Computer'),
        centerTitle: true, // Center the title text
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Morse Code Input:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              _morseCode,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _appendToMorseCode('.'),
                  child: const Text('.'),
                ),
                ElevatedButton(
                  onPressed: () => _appendToMorseCode('-'),
                  child: const Text('-'),
                ),
                ElevatedButton(
                  onPressed: () => _appendToMorseCode(' '),
                  child: const Text('Space'),
                ),
                ElevatedButton(
                  onPressed: () => _appendToMorseCode('/'),
                  child: const Text('/'),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _translateMorseCode,
              child: const Text('Translate'),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Translated Text:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              _translatedText,
              style: const TextStyle(fontSize: 16.0),
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(fontSize: 20.0),
      ),
    );
  }
}
