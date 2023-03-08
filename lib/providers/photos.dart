import 'dart:async';
import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:flutter_api_retriever/classes/photo.dart';
import 'package:http/http.dart' as http;

class PhotosProvider with ChangeNotifier {
  int _id = 1;

  int get getId => _id;

  void changeId(int id) {
    _id = id;
    notifyListeners();
  }

  Future<List<Photo>> fetchPhotos(http.Client client) async {
    final response = await client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/photos/?albumId=$_id'));

    // Use the compute function to run parsePhotos in a separate isolate.
    return compute(parsePhotos, response.body);
  }

// A function that converts a response body into a List<Photo>.
  List<Photo> parsePhotos(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
  }
}
