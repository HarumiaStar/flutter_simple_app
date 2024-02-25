import 'dart:convert';
import 'package:flutter_simple_app/models/author_model.dart';
import 'package:http/http.dart' as http;

class AuthorApi {


  static Future<List<AuthorModel>> getAuthors(String name) async {
    var uri = Uri.https('openlibrary.org', 'search/authors.json',
        {'q': name});
      
    final response = await http.get(uri);

    Map data = jsonDecode(response.body);
    List temp = [];

    for (var author in data['docs']) {
      temp.add(author);
    }

    return AuthorModel.authorFromSnapshot(temp);
  }
}