import 'dart:async';

import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';

/// Dont forget this import since we are doing a One_To_Many relation
import './user.dart';

/// Need to write this line before running  [flutter pub run build_runner build]
part 'post.jorm.dart';

// The model
class Post {
  Post();

  Post.make(this.id, this.msg);

  /// auto = auto-increment
  @PrimaryKey(auto: true)
  int id;

  @Column(isNullable: false)
  String msg;

  /// Permits to create a One_To_Many relation between 2 tables
  /// In this example, a User can be linked to various posts
  /// Each Post then has to hold a reference to the User who wrote it:
  /// This is the [Foreign Key] => generally it is the primary key of Parent Table
  /// - [@BelongsTo] has to be set in a Child Tale
  /// - [UserBean] is the Parent Table of reference
  /// - [refCol] permits to set the column used to get the [Foreign Key]
  ///    -> by default it uses the primary key column of the parent Table
  /// - [int userId] is the name of the column holding the [Foreign Key]
  ///   from the Parent Table in the Child Table
  @BelongsTo(UserBean, refCol: 'id')
  int userId;

  String toString() => 'Post(id: $id, message: $msg)';
}

/// Need to write this line before running  [flutter pub run build_runner build]
@GenBean()
class PostBean extends Bean<Post> with _PostBean {
  UserBean _userBean;

  /// Reference to the Parent Class (Table)
  /// it is used when making the relation
  UserBean get userBean => _userBean ??= new UserBean(adapter);

  PostBean(Adapter adapter) : super(adapter);

  final String tableName = 'posts';
}
