import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:forumapp/constants/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthenticationController extends GetxController {
  final isLoading = false.obs;

  Future register(
      {required String name,
      required String username,
      required String email,
      required String password}) async {
    try {
      isLoading.value = true;
      var data = {
        'name': name,
        'username': username,
        'email': email,
        'password': password
      };

      var response = await http.post(Uri.parse('${url}register'),
          headers: {'Accept': 'application/json'}, body: data);

      if (response.statusCode == 201) {
        debugPrint(jsonEncode(response.body));
      } else {
        debugPrint(jsonEncode(response.body));
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }
}
