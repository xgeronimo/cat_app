import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cat_model.dart';

class CatService {
  final String _apiKey =
      'live_eyvfeJ7AgaiGRGzrEXSkgCaBejGmBpmVLmsSGbtvswhsfXGnhktrR35b4638CUgZ';

  Future<Cat> fetchCat() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.thecatapi.com/v1/images/search?has_breeds=1'),
        headers: {'x-api-key': _apiKey},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Cat.fromJson(data[0]);
      } else {
        throw Exception('Failed to load cat image: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load cat image: $e');
    }
  }
}
