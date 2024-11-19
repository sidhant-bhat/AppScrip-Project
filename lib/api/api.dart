import 'dart:convert';

import 'package:flutter_application_1/model/model.dart';
import 'package:http/http.dart' as http;

class ApiCalls {
  Future<List<User>> getUsers() async {
    var uri = Uri.parse("https://jsonplaceholder.typicode.com/users");
    var response = await http.get(uri);
    List<dynamic> resp = jsonDecode(response.body);
    List<User> userList = User().fromListJson(resp);
    return userList;
  }
}
