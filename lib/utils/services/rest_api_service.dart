import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:authentification/constants/api_path.dart';
import 'package:authentification/modules/auth/models/login.dart';

class RestApiService {
  static Future<Login> login(String email, String password) async {
    final url = Uri.parse(ApiPath.loginRequestUrl);
    final body = jsonEncode({
      'id': 0,
      'fullName': 'string',
      'emailId': email,
      'password': password,
      'designation': 'string',
      'userMessage': 'string',
      'accessToken': 'string',
      'createdDate': '2023-07-07T13:32:55.029Z'
    });
    final headers = {'Content-Type': 'application/json'};

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final accessToken = json['accessToken'] as String?;
      final message = json['userMessage'] as String?;
      return Login(accessToken: accessToken, message: message);
    } else {
      throw Exception("Wrong credentials");
    }
  }
}
