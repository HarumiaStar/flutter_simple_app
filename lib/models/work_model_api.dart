import 'dart:convert';
import 'package:flutter_simple_app/models/work_model.dart';
import 'package:http/http.dart' as http;

class WorkApi {

  static Future<List<WorkModel>> getWorksByAuthor(String name) async {
    var uri = Uri.https('openlibrary.org', 'authors/$name/works.json');
      
    final response = await http.get(uri);

    Map data = jsonDecode(response.body);

    if (data['entries'] != null) {
      List temp = [];
      for (var work in data['entries']) {
        temp.add(work);
      }
      return WorkModel.workFromSnapshot(temp);
    }
    return [];
  }
}