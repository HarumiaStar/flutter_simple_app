import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_simple_app/models/author_model.dart';
import 'package:flutter_simple_app/models/work_model_api.dart';
import 'package:flutter_simple_app/models/work_model.dart';
import 'dart:developer' as developer;

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.name});
  final String name;
  String get getName => name;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<WorkModel> works = [];

  @override
  void initState() {
    super.initState();
    getWorks(widget.getName);
  }

  Future<void> getWorks(String name) async {
    try {
      works = await WorkApi.getWorksByAuthor(widget.getName);
      setState(() {
        works = works;
      });
    } catch (e) {
      developer.log('error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final author = ModalRoute.of(context)!.settings.arguments as AuthorModel;

    if (works.isEmpty) {
      return Scaffold(
        appBar: detailsAppBar(author),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Use the Todo to create the UI.
    return Scaffold(
      appBar: detailsAppBar(author),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(5.0),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: works.length,
            itemBuilder: (context, index) {
              return Container(
                color: (index % 2 == 0)
                    ? const Color.fromARGB(12, 0, 0, 0)
                    : Colors.white,
                child: ListTile(
                  title: Text(works[index].title),
                  leading: Container(
                    width: 30,
                    height: 30,
                    decoration: works[index].coverUrl != 'N/A'
                        ? BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(works[index].coverUrl),
                              fit: BoxFit.cover,
                            ),
                          )
                        : null,
                    child: works[index].coverUrl == 'N/A'
                        ? const Icon(Icons.book_outlined, color: Colors.black)
                        : null,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  AppBar detailsAppBar(AuthorModel author) {
    return AppBar(
      title: Text(author.name),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_month_outlined),
                const SizedBox(width: 8.0),
                Flexible(
                  child: Text('${author.birthDate} - ${author.deathDate}',
                      style: const TextStyle(fontSize: 12)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star_border_outlined),
                const SizedBox(width: 8.0),
                Flexible(
                  child: Text(author.topWork,
                      style: const TextStyle(fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
