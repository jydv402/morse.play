class MorseEntry {
  final String char;
  final String code;
  const MorseEntry({required this.char, required this.code});
}

class MorseService {
  static const List<MorseEntry> bookEntries = [
    MorseEntry(char: 'A', code: '.-'),
    MorseEntry(char: 'B', code: '-...'),
    MorseEntry(char: 'C', code: '-.-.'),
    MorseEntry(char: 'D', code: '-..'),
    MorseEntry(char: 'E', code: '.'),
    MorseEntry(char: 'F', code: '..-.'),
    MorseEntry(char: 'G', code: '--.'),
    MorseEntry(char: 'H', code: '....'),
    MorseEntry(char: 'I', code: '..'),
    MorseEntry(char: 'J', code: '.---'),
    MorseEntry(char: 'K', code: '-.-'),
    MorseEntry(char: 'L', code: '.-..'),
    MorseEntry(char: 'M', code: '--'),
    MorseEntry(char: 'N', code: '-.'),
    MorseEntry(char: 'O', code: '---'),
    MorseEntry(char: 'P', code: '.--.'),
    MorseEntry(char: 'Q', code: '--.-'),
    MorseEntry(char: 'R', code: '.-.'),
    MorseEntry(char: 'S', code: '...'),
    MorseEntry(char: 'T', code: '-'),
    MorseEntry(char: 'U', code: '..-'),
    MorseEntry(char: 'V', code: '...-'),
    MorseEntry(char: 'W', code: '.--'),
    MorseEntry(char: 'X', code: '-..-'),
    MorseEntry(char: 'Y', code: '-.--'),
    MorseEntry(char: 'Z', code: '--..'),
    MorseEntry(char: '0', code: '-----'),
    MorseEntry(char: '1', code: '.----'),
    MorseEntry(char: '2', code: '..---'),
    MorseEntry(char: '3', code: '...--'),
    MorseEntry(char: '4', code: '....-'),
    MorseEntry(char: '5', code: '.....'),
    MorseEntry(char: '6', code: '-....'),
    MorseEntry(char: '7', code: '--...'),
    MorseEntry(char: '8', code: '---..'),
    MorseEntry(char: '9', code: '----.'),
    MorseEntry(char: '.', code: '.-.-.-'),
    MorseEntry(char: ',', code: '--..--'),
    MorseEntry(char: '?', code: '..--..'),
    MorseEntry(char: '!', code: '-.-.--'),
    MorseEntry(char: '/', code: '-..-.'),
    MorseEntry(char: '(', code: '-.--.'),
    MorseEntry(char: ')', code: '-.--.-'),
    MorseEntry(char: ':', code: '---...'),
    MorseEntry(char: ';', code: '-.-.-.'),
    MorseEntry(char: '=', code: '-...-'),
    MorseEntry(char: '+', code: '.-.-.'),
    MorseEntry(char: '-', code: '-....-'),
    MorseEntry(char: '"', code: '.-..-.'),
    MorseEntry(char: '\$', code: '...-..-'),
    MorseEntry(char: '@', code: '.--.-.'),
    MorseEntry(char: '&', code: '.-...'),
    MorseEntry(char: '_', code: '..--.-'),
    MorseEntry(char: '\'', code: '.----.'),
  ];

  /// Static map of morse code.
  static const Map<String, String> morseCode = {
    'A': '.-',
    'B': '-...',
    'C': '-.-.',
    'D': '-..',
    'E': '.',
    'F': '..-.',
    'G': '--.',
    'H': '....',
    'I': '..',
    'J': '.---',
    'K': '-.-',
    'L': '.-..',
    'M': '--',
    'N': '-.',
    'O': '---',
    'P': '.--.',
    'Q': '--.-',
    'R': '.-.',
    'S': '...',
    'T': '-',
    'U': '..-',
    'V': '...-',
    'W': '.--',
    'X': '-..-',
    'Y': '-.--',
    'Z': '--..',
    '0': '-----',
    '1': '.----',
    '2': '..---',
    '3': '...--',
    '4': '....-',
    '5': '.....',
    '6': '-....',
    '7': '--...',
    '8': '---..',
    '9': '----.',
    '.': '.-.-.-',
    ',': '--..--',
    '?': '..--..',
    '!': '-.-.--',
    '/': '-..-.',
    '(': '-.--.',
    ')': '-.--.-',
    ':': '---...',
    ';': '-.-.-.',
    '=': '-...-',
    '+': '.-.-.',
    '-': '-....-',
    '"': '.-..-.',
    '\$': '...-..-',
    '@': '.--.-.',
    '&': '.-...',
    '_': '..--.-',
    '\'': '.----.',
  };

  /// Static method to convert text to Morse.
  /// Standard Morse: 1 space between letters, 3 spaces between words.
  static String convert(String text) {
    if (text.isEmpty) return '';
    return text
        .trim()
        .toUpperCase()
        .split(' ')
        .map(
          (word) =>
              word.split('').map((char) => morseCode[char] ?? char).join(' '),
        )
        .join('   ');
  }

  // Non-static conversion logic (optional, for instance calls)
  String textToMorse(String text) {
    return convert(text);
  }
}
