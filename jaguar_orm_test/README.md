# jaguar_orm_test

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.




JAGUAR_ORM for flutter

 -> dependencies:
  	flutter:
   		sdk: flutter
	path: ^1.6.4 -------------------------> import 'package:path/path.dart';
 	sqflite: ^1.1.6+4 -------------------->	import 'package:sqflite/sqflite.dart';
  	jaguar_query_sqflite: ^2.2.10 --------> import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
  	jaguar_orm: ^2.2.6 -------------------> import 'package:jaguar_orm/jaguar_orm.dart';
  	build_runner: ^1.7.0 ----------------->	import 'package:build_runner/build_runner.dart';
  	jaguar_orm_gen: ^2.2.27	-------------->	import 'package:jaguar_orm_gen/builder.dart';
						import 'package:jaguar_orm_gen/jaguar_orm_cli.dart';


jaguar_orm Library:
						https://pub.dev/documentation/jaguar_orm/latest/jaguar_orm/jaguar_orm-library.html
jaguar_orm Full Git Repo:
						https://github.com/Jaguar-dart/jaguar_orm
						
GitHub Example with Jaguar_ORM and  SQFLite: 
						https://github.com/jaguar-orm/sqflite
GitHub Example with Jaguar_ORM -> WHERE:
						https://github.com/jaguar-orm/where/blob/master/bin/user.dart
GitHub Example with Jaguar_ORM -> One_To_Many 
						https://github.com/jaguar-orm/composite1toN/blob/master/bin/main.dart
						https://github.com/jaguar-orm/sqflite/blob/master/lib/one_to_many/item.dart
					
 
 workflow:
    -> install dependencies
    -> create model. i.e: post.dart as it is!
        -> needs the  part 'post.jorm.dart'; and the class PostBean extends Bean<Post> with _PostBean {}
    -> on CLI: flutter pub run build_runner build   --> to automaticaly create the post.jorm.dart
    ->