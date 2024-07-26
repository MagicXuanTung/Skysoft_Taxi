import 'package:http/http.dart' as http;
import 'dart:convert';

class AutocompleteService {
  Future<List<String>> getSuggestions(String query) async {
    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&polygon_geojson=1&addressdetails=1');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data
          .map<String>((item) => item['display_name'].toString())
          .toList();
    } else {
      throw Exception('Failed to load suggestions');
    }
  }
}
