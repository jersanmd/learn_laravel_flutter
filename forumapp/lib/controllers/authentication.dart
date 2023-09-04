import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forumapp/constants/constants.dart';
import 'package:forumapp/views/home.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;

  final box = GetStorage();

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
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);
        Get.offAll(() => const HomePage());
      } else {
        Get.snackbar('Error', json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
        debugPrint(jsonEncode(response.body));
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future login({required String username, required String password}) async {
    try {
      isLoading.value = true;
      var data = {'username': username, 'password': password};

      var response = await http.post(Uri.parse('${url}login'),
          headers: {'Accept': 'application/json'}, body: data);

      if (response.statusCode == 200) {
        debugPrint(jsonEncode(response.body));
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);
        Get.offAll(() => const HomePage());
      } else {
        Get.snackbar('Error', json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
        debugPrint(jsonEncode(response.body));
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }
}
