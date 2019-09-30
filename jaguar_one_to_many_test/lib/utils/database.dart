import 'package:flutter/material.dart';
// import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
// import 'package:path/path.dart' as path;
// import 'package:sqflite/sqflite.dart';

// import '../models/post.dart';

class DatabaseObject with ChangeNotifier {
  final List<dynamic> beanList;

  DatabaseObject(this.beanList);
}
