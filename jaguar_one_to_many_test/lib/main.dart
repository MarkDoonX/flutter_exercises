import 'package:flutter/material.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:provider/provider.dart';

import './models/post.dart';
import './models/user.dart';
import './utils/database.dart';

SqfliteAdapter _adapter;

void main() async {
  final List<dynamic> beanList = [];

  var dbPath = await getDatabasesPath();
  _adapter = SqfliteAdapter(path.join(dbPath, "jaguar_orm_test.db"));
  await _adapter.connect();

  /// Instanciating tables objects
  final postBean = PostBean(_adapter);
  final userBean = UserBean(_adapter);

  /// Creating Tables if they do not exist
  await postBean.createTable(ifNotExists: true);
  await userBean.createTable(ifNotExists: true);

  /// Adding beans to the list of usable beans
  beanList.add(postBean);
  beanList.add(userBean);

  DatabaseObject(beanList);

  runApp(MyApp(beanList));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final List<dynamic> beanList;
  MyApp(this.beanList);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: DatabaseObject(beanList)),
      ],
      child: MaterialApp(
        title: 'Jaguar Test',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DatabaseObject database = Provider.of<DatabaseObject>(context);

    final PostBean postBean = database.beanList[0];
    final UserBean userBean = database.beanList[1];

    final user1 = User.make(null, 'Jean-Eude');
    final user2 = User.make(null, 'Philibert');
    final user3 = User.make(null, 'Pierre-Henry');

    /// we do not indicate the parent User here
    /// see [postBean.associateUser]
    final post1 = Post.make(null, 'test1');
    final post2 = Post.make(null, 'test1');
    final post3 = Post.make(null, 'test1');

    return Scaffold(
      appBar: AppBar(
        title: Text('JAGUAR ORM'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
//**********/// USERS FUNCTIONS
            Row(
              children: <Widget>[
                /// Add user
                RaisedButton(
                  onPressed: () async {
                    /// it's important to indicate [cascade: true], because it permits
                    /// to indicate that this user can have children posts
                    await userBean.insert(user1, cascade: true);
                    await userBean.insert(user2, cascade: true);
                    await userBean.insert(user3, cascade: true);
                  },
                  child: Text('Add User'),
                ),

                /// Print Users
                RaisedButton(
                  onPressed: () async {
                    List<User> users = await userBean.getAll();
                    users.forEach((user) {
                      print("id: ${user.id}, name: ${user.name}");
                    });
                  },
                  child: Text('Print Users'),
                ),
              ],
            ),

//**********/// POSTS FUNCTIONS
            Row(
              children: <Widget>[
                /// Add post
                RaisedButton(
                  onPressed: () async {
                    /// Getting an instance of the User that will be the Parent of the Posts
                    User user = await userBean
                        .findOneWhere(userBean.name.eq('Philibert'));

                    /// associate permits to fill the [Foreign Key] Column of the [Children Post]
                    /// with the [Primary Key] of the [Parent User]
                    // postBean.associateUser(post1, user);
                    // postBean.associateUser(post2, user);
                    // postBean.associateUser(post3, user);
                    post1.userId = 8;
                    post2.userId = 8;
                    post3.userId = 8;

                    await postBean.insert(post1);
                    await postBean.insert(post2);
                    await postBean.insert(post3);
                  },
                  child: Text('Add Posts to a User'),
                ),

                /// Print Posts
                RaisedButton(
                  onPressed: () async {
                    List<Post> posts = await postBean.getAll();
                    posts.forEach((post) {
                      print(
                          "id: ${post.id}, name: ${post.msg}, userId: ${post.userId}");
                    });
                  },
                  child: Text('Print Posts'),
                ),
              ],
            ),

            /// Get all posts from named User
            RaisedButton(
              onPressed: () async {
                // List<Post> posts = await postBean.getAll();
              },
              child: Text('Add User'),
            ),
          ],
        ),
      ),
    );
  }
}
