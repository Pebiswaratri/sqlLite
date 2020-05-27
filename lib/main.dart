import 'package:flutter/material.dart';
// change `flutter_database` to whatever your project name is
import 'database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  // homepage layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sqflite CRUD'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Tambah', style: TextStyle(fontSize: 20),),
              onPressed: () {_insert();},
            ),
            RaisedButton(
              child: Text('Lihat', style: TextStyle(fontSize: 20),),
              onPressed: () {_query();},
            ),
            RaisedButton(
              child: Text('Ubah', style: TextStyle(fontSize: 20),),
              onPressed: () {_update();},
            ),
            RaisedButton(
              child: Text('Hapus', style: TextStyle(fontSize: 20),),
              onPressed: () {_delete();},
            ),
          ],
        ),
      ),
    );
  }

  // Button onPressed methods

  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : 'Ni Putu Pande Pebi Swaratri',
      DatabaseHelper.columnAge  : 20
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  void _update() async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnName : 'Sanistya Pradnyani',
      DatabaseHelper.columnAge  : 16
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
}