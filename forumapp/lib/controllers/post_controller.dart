import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forumapp/constants/constants.dart';
import 'package:forumapp/models/post_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PostController extends GetxController {
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);
  final isLoading = false.obs;
  final box = GetStorage();

  @override
  void onInit() {
    getAllPosts();
    super.onInit();
  }

  Future getAllPosts() async {
    isLoading.value = true;
    try {
      posts.value.clear();
      var response = await http.get(Uri.parse('${url}feeds'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}'
      });

      if (response.statusCode == 200) {
        final content = json.decode(response.body)['feeds'];
        for (var item in content) {
          posts.value.add(PostModel.fromJson(item));
        }
      } else {
        Get.snackbar('Error', json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future createPost({required String content}) async {
    isLoading.value = true;
    try {
      var data = {'content': content};
      var response = await http.post(Uri.parse('${url}feed/store'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}'
          },
          body: data);

      if (response.statusCode == 201) {
        // print(json.decode(response.body));
      } else {
        Get.snackbar('Error', json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }
}
