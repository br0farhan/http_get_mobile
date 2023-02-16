import 'dart:convert';

import 'package:get_http/models/user.dart';
import 'package:http/http.dart' as http;

class UserServices {
  static const String baseurl = "https://reqres.in/api";
  static Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('$baseurl/users?page=2'));
      final body = response.body;
      final result = jsonDecode(body);
    List<User> users = List<User>.from(result["data"].map(
      (user)=> User.fromjson(user) 
    ));
      return users;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
