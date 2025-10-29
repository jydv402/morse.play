class MorseService {
  // The Morse code dictionary.
  final Map<String, String> morseCode = const {
    // Alphabets in uppercase
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

    // Numbers
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

    // Symbols
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

  // Coversion logic
  String textToMorse(String text) {
    // 1. Convert everything to uppercase.
    // 2. Split into individual characters.
    // 3. Obtain values for each keys (char):
    //    - If it's a space, return two spaces ('  ') to represent a word break in Morse.
    //    - Otherwise, look up the Morse code. If the character is not found, keep the original character.
    // 4. Join the resulting Morse codes with a single space (' ') to represent a letter break.
    return text
        .toUpperCase()
        .split('')
        .map((char) {
          // Return two spaces if char is a space
          if (char == ' ') return '  ';
          // '??' -> Null aware operator : if char is not found within the map, return char
          return morseCode[char] ?? char;
        })
        .join(' ');
  }
}
