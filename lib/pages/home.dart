import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_simple_app/models/author_model.dart';
import 'package:flutter_simple_app/models/author_model_api.dart';
import 'package:flutter_simple_app/pages/details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<AuthorModel> authors = [];
  String nameSearch = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    getAuthors('');
  }

  Future<void> getAuthors(String name) async {
    setState(() {
      nameSearch = name;
    });
    authors = await AuthorApi.getAuthors(nameSearch);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchField(),
          const SizedBox(height: 40.0),
          if (nameSearch != '') _listAuthors(),
        ],
      ),
    );
  }

  Column _listAuthors() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Authors',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 15.0),
        Container(
          margin: const EdgeInsets.all(5.0),
          height: 550.0,
          child: FutureBuilder<List<AuthorModel>>(
            future: AuthorApi.getAuthors(nameSearch),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: authors.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: (index % 2 == 0)
                          ? const Color.fromARGB(12, 0, 0, 0)
                          : Colors.white,
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.person),
                                const SizedBox(width: 8.0),
                                Flexible(
                                  child: Text(authors[index].name,
                                      style: const TextStyle(fontSize: 16)),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.calendar_month_outlined),
                                const SizedBox(
                                    width:
                                        8.0), // Add some space between the icon and text
                                Flexible(
                                  child: Text(
                                      '${authors[index].birthDate} - ${authors[index].deathDate}',
                                      style: const TextStyle(fontSize: 14)),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.book_outlined),
                                const SizedBox(
                                    width:
                                        8.0), // Add some space between the icon and text
                                Flexible(
                                  child: Text(authors[index].topWork,
                                      style: const TextStyle(fontSize: 14)),
                                )
                              ],
                            ),
                          ],
                        ),
                        trailing:
                            const Icon(Icons.label_important_outline_sharp),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(name: authors[index].key),
                              settings: RouteSettings(
                                arguments: authors[index],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }

  Container _searchField() {
    return Container(
      margin: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xff1D1617).withOpacity(0.11),
            blurRadius: 40.0,
            spreadRadius: 0.0,
          )
        ],
      ),
      child: TextField(
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(15.0),
          hintText: 'Search an author name',
          hintStyle: TextStyle(
              color: Color.fromARGB(255, 184, 184, 184), fontSize: 14.0),
          prefixIcon: Icon(Icons.search, color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide.none,
          ),
        ),
        onSubmitted: (String value) => {
          setState(() {
            getAuthors(value);
          }),
        },
        onChanged: (String value) => {
          if (_timer?.isActive ?? false) _timer?.cancel(),
          _timer = Timer(const Duration(milliseconds: 300), () {
            setState(() {
              getAuthors(value);
            });
          }),
        },
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Home',
        style: TextStyle(
            color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(0, 114, 157, 152),
      elevation: 0.0,
    );
  }
}
