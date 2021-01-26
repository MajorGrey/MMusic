import 'package:flutter/material.dart';
import "package:MusicApp/database.dart";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var files;

  void getFiles() async {}
  final db = Db.instance;

  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {Db.columnName: 'Bob', Db.columnValue: 23};
    final id = await db.insert(row);
    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await db.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  void _update() async {
    // row to update
    Map<String, dynamic> row = {
      Db.columnId: 1,
      Db.columnName: 'Mary',
      Db.columnValue: 32
    };
    final rowsAffected = await db.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await db.queryRowCount();
    final rowsDeleted = await db.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }

  @override
  void initState() {
    super.initState();
    getFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff000000),
        title: Row(
          children: [
            Icon(
              Icons.music_note_outlined,
              color: Colors.green,
            ),
            Text(
              "MMusic",
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 8.0, 8.0, 8.0),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  pinned: true,
                  expandedHeight: 250.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Row(
                      children: [
                        Icon(
                          Icons.music_note_outlined,
                          color: Colors.green,
                        ),
                        Text(
                          "MMusic",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
