import 'dart:async';

import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';

/// Dont forget this import since we are doing a One_To_Many relation
import './post.dart';

/// Need to write this line before running  [flutter pub run build_runner build]
part 'user.jorm.dart';

/// The model
class User {
  User();

  User.make(this.id, this.name);

  @PrimaryKey(auto: true)
  int id;

  @Column(isNullable: false)
  String name;

  /// [@HasMany] is not a column in the table, it is only a list
  /// of Children that hold this User's Primary Key
  /// [PostBean] is the Children Table
  @HasMany(PostBean)
  List<Post> posts;

  String toString() => 'User(id: $id, message: $name)';
}

/// Need to write this line before running  [flutter pub run build_runner build]
@GenBean()
class UserBean extends Bean<User> with _UserBean {
  UserBean(Adapter adapter)
      : postBean = PostBean(adapter),
        super(adapter);

  final PostBean postBean;

  final String tableName = 'users';
}
