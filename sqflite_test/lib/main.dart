import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import './utils/dogs_database.dart';
import './models/dog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQFLite test'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            /// Add new dog of name X into table Y
            TextField(
              decoration: InputDecoration(
                  labelText: 'Add new dog of name X into table Y'),
              onSubmitted: (String name) async {
                final dog = Dog(
                  name: name,
                  age: 10,
                );
                final dogsDataBase = DogsDataBase();
                await dogsDataBase.insertDog(dog, 'dogs2');
              },
            ),

            /// Print Dogs
            TextField(
              decoration: InputDecoration(labelText: 'Print dogs from TABLE:'),
              onSubmitted: (String tableName) async {
                final dogsDataBase = DogsDataBase();
                await dogsDataBase.printDogs(tableName);
              },
            ),

            /// Create new Table of name...
            TextField(
              decoration: InputDecoration(labelText: 'CREATE TABLE of name:'),
              onSubmitted: (String tableName) async {
                final dogsDataBase = DogsDataBase();
                await dogsDataBase.createNewTable(tableName);
              },
            ),

            /// Drop named Table
            TextField(
              decoration: InputDecoration(labelText: 'DROP TABLE of name:'),
              onSubmitted: (String tableName) async {
                final dogsDataBase = DogsDataBase();
                await dogsDataBase.dropTable(tableName);
              },
            ),

            /// Print Tables List
            RaisedButton(
              child: Text('Print Tables List'),
              onPressed: () async {
                final dogsDataBase = DogsDataBase();
                await dogsDataBase.printTablesList();
              },
            ),

            /// OpenDB
            RaisedButton(
              child: Text('Open DB / Create dogs1 TABLE if first time'),
              onPressed: () async {
                final dogsDataBase = DogsDataBase();
                await dogsDataBase.openDB();
              },
            ),
          ],
        ),
      ),
    );
  }
}
