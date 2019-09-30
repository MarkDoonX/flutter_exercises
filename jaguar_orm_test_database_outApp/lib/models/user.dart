import 'dart:async';

import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';

part 'user.jorm.dart';

// The model
class User {
  User();

  User.make(this.id, this.name, this.age, this.email);

  @PrimaryKey(auto: true)
  int id;

  @Column(isNullable: false)
  String name;

  @Column(isNullable: false)
  int age;

  @Column(isNullable: false)
  String email;

  

  String toString() =>
      'User(id: $id, message: $name, stars: $age, read: $email)';
}

@GenBean()
class UserBean extends Bean<User> with _UserBean {
  UserBean(Adapter adapter) : super(adapter);

  final String tableName = 'users';
}