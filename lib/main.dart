import 'package:flutter_simple_app/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Suzanne R app',
      debugShowCheckedModeBanner: false,
      home: HomePage()//AuthorsScreen(),
    ),
  );
}