import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moosic/Data/Models/models/songsmodel.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

final _searchController = TextEditingController();
List<Songs> songList = Hive.box<Songs>(boxname).values.toList();
List<Songs> songDisplay = List<Songs>.from(songList);

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            searchTextField(
              context: context,
            ),
          ],
        ),
      ),
    ));
  }
}

Widget searchTextField({required BuildContext context}) {
  return TextFormField(
    autofocus: true,
    controller: _searchController,
    cursorColor: Colors.black,
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(
      prefixIcon: const Icon(Icons.search),
      suffixIcon: IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => Navigator.of(context).pop(),
      ),
      filled: true,
      fillColor: const Color.fromRGBO(234, 236, 238, 2),
      border: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(50)),
      hintText: 'search',
    ),
    onChanged: (value) {
      // _searchStudent(value);
    },
  );
}
