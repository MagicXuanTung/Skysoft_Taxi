import 'dart:convert';

import 'package:http/http.dart';
import 'package:skysoft_taxi/url/contants.dart';

Future<List<dynamic>> getAll() async {
  Response response = await get(Uri.parse(URL_CHAT_GETALL));
  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    return responseData["chats"];
  } else {
    print('Upload thất bại. Mã lỗi: ${response.statusCode}');
  }
  return [];
}
