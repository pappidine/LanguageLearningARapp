import 'package:http/http.dart' as http;
import 'dart:convert';

class GoogleTranslateService {
  static const String _baseUrl =
      'https://translation.googleapis.com/language/translate/v2';

  final String apiKey;

  GoogleTranslateService(this.apiKey);

  Future<String> translateText(String text, String targetLanguage) async {
    final url = '$_baseUrl?key=$apiKey';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'q': text,
        'target': targetLanguage,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final translatedText = data['data']['translations'][0]['translatedText'];
      return translatedText;
    } else {
      throw 'Translation failed';
    }
  }
}
