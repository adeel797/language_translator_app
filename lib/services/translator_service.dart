import 'package:translator/translator.dart';

class TranslatorService {
  final GoogleTranslator _translator = GoogleTranslator();

  final List<String> languages = [
    'English',
    'Urdu',
    'Hindi',
    'Spanish',
    'French',
    'German',
    'Arabic',
    'Russian',
    'Japanese',
    'Korean',
  ];

  final Map<String, String> langCodes = {
    'English': 'en',
    'Urdu': 'ur',
    'Hindi': 'hi',
    'Spanish': 'es',
    'French': 'fr',
    'German': 'de',
    'Arabic': 'ar',
    'Russian': 'ru',
    'Japanese': 'ja',
    'Korean': 'ko',
  };

  /// Translate text between given languages
  Future<String> translateText({
    required String input,
    required String fromLang,
    required String toLang,
  }) async {
    if (input.trim().isEmpty) {
      return 'Please enter text to translate.';
    }

    try {
      final result = await _translator.translate(
        input,
        from: langCodes[fromLang]!,
        to: langCodes[toLang]!,
      );

      return result.text.isEmpty ? 'Translation failed.' : result.text;
    } catch (e) {
      return 'Error: $e';
    }
  }
}
