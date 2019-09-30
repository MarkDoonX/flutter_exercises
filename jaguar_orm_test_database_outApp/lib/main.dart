import 'package:flutter/material.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:provider/provider.dart';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';

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
  // await postBean.createTable(ifNotExists: true);
  // await userBean.createTable(ifNotExists: true);

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

    final Post post1 =
        Post.make(null, "is it working?", 4.2, true, DateTime.now());
    final Post post2 =
        Post.make(null, "yes it works!!!", 4.2, true, DateTime.now());
    final Post post3 = Post.make(null, "test1", 3, true, DateTime.now());
    final Post post4 = Post.make(null, "test2", 3, true, DateTime.now());

    final User user1 = User.make(null, "Jean", 50, "jean@jean.com");
    final User user2 = User.make(null, "Patrick", 35, "patrick@patrick.com");
    final User user3 = User.make(null, "Patrick", 40, "patrick@patrick.com");
    final User user4 = User.make(null, "Patrick", 50, "patrick@patrick.com");
    final User user5 = User.make(null, "Francis", 35, "francis@francis.com");
    final User user6 = User.make(null, "Francis", 50, "francis@francis.com");
    final User userUpdate = User.make(6, "Eric", 50, "eric@eric.com");
    final User userUpsert = User.make(6, "Rudolf", 50, "rudolf@rudolf.com");
    final User userUpsert2 = User.make(null, "Rudolf", 50, "rudolf@rudolf.com");

    return Scaffold(
      appBar: AppBar(
        title: Text('JAGUAR ORM'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // List TABLES
            RaisedButton(
              onPressed: () {
                print("hrhe");
              },
              child: Text("list tables"),
            ),

//**********/// POST FUNCTIONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                /// INSERT POST into posts table
                RaisedButton(
                  onPressed: () async {
                    print('INSERT POST into posts table: ');
                    await postBean.insert(post1);
                    await postBean.insert(post2);
                    await postBean.insert(post3);
                    await postBean.insert(post4);
                  },
                  child: Text('InsertP'),
                ),

                /// GET All POST
                RaisedButton(
                  onPressed: () async {
                    List<Post> posts = await postBean.getAll();
                    print('GET All POST');
                    posts.forEach(
                        (post) => print("id: ${post.id}, ${post.msg}"));
                  },
                  child: Text('GetAllP'),
                ),

                /// Find 1 Post
                RaisedButton(
                  onPressed: () async {
                    print('Find 1 POST of id...: ');
                    Post post = await postBean.find(2);
                    print("id: ${post.id}, ${post.msg}");
                  },
                  child: Text('Get1P'),
                ),

                // Find All Posts Where
                RaisedButton(
                  onPressed: () async {
                    print('Find all POST where id between 3 and 7 included: ');
                    List<Post> posts =
                        await postBean.findWhere(postBean.id.between(3, 7));
                    posts.forEach(
                        (post) => print("id: ${post.id}, ${post.msg}"));
                  },
                  child: Text('FindX'),
                ),
              ],
            ),
            Container(
              height: 20,
            ),

//**********/// USER FUNCTIONS 1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                /// INSERT USER into users table
                RaisedButton(
                  onPressed: () async {
                    print('Inser all users: ');
                    await userBean.insert(user1);
                    await userBean.insert(user2);
                    await userBean.insert(user3);
                    await userBean.insert(user4);
                    await userBean.insert(user5);
                    await userBean.insert(user6);
                  },
                  child: Text('InsertU'),
                ),

                /// GET All POST
                RaisedButton(
                  onPressed: () async {
                    print('Get all Users: ');
                    List<User> users = await userBean.getAll();
                    users.forEach((user) => print(
                        "id: ${user.id}, ${user.name}, ${user.age}, ${user.email}"));
                  },
                  child: Text('GetAllU'),
                ),

                /// Find Where , AND, BETWEEN
                RaisedButton(
                  onPressed: () async {
                    print(
                        'Find where name = Patrick Or Jean & age betwee 40-50 included: ');
                    List<User> users = await userBean.findWhere(
                      (userBean.name.eq('Patrick') | userBean.name.eq('Jean')) &
                          userBean.age.between(40, 50),
                    );
                    users.forEach((user) => print(
                        "id: ${user.id}, ${user.name}, ${user.age}, ${user.email}"));
                  },
                  child: Text('FindX'),
                ),

                /// UPDATE user
                RaisedButton(
                  onPressed: () async {
                    print('Update where name = ... with a new name: ');
                    await userBean.updateFields(
                        userBean.name.eq('Fr'), {"name": 'Francis'});
                  },
                  child: Text('UpdateU'),
                ),
              ],
            ),

//**********/// USER FUNCTIONS 2
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                /// UPSERT USER into users table
                RaisedButton(
                  onPressed: () async {
                    print(
                        'Updates if user exists with id 6 and null, or Inserts it: ');
                    // upserting means it inserts if it doesnt exist, and it updates if it exists
                    await userBean.upsert(userUpsert);
                    await userBean.upsert(userUpsert2);
                  },
                  child: Text('UpsertU'),
                ),

                /// REMOVE Where
                RaisedButton(
                  onPressed: () async {
                    print('Remove where name = Rudolf');
                    await userBean.removeWhere(userBean.name.eq('Rudolf'));
                  },
                  child: Text('RemU'),
                ),

                /// Find Where email String contains %String%
                RaisedButton(
                  onPressed: () async {
                    print('Find where email contains patrick');
                    List<User> users = await userBean.findWhere(
                      userBean.email.like('%patrick%'),
                    );
                    users.forEach((user) => print(
                        "id: ${user.id}, ${user.name}, ${user.age}, ${user.email}"));
                  },
                  child: Text('FindULike'),
                ),

                /// UPDATE user with new model
                RaisedButton(
                  onPressed: () async {
                    // update a user by giving a new model. The model needs a non-null id to know
                    // where to update
                    print('Updates user of given id');
                    await userBean.update(userUpdate);
                  },
                  child: Text('UpdateU'),
                ),
              ],
            ),
            Container(
              height: 20,
            ),

//**********/// REMOVE All USERS
            RaisedButton(
              onPressed: () async {
                print('Remove all users');
                await userBean.removeAll();
              },
              child: Text('clear Users'),
            ),

//**********/// REMOVE All POSTS
            RaisedButton(
              onPressed: () async {
                print('Removea all posts');
                await postBean.removeAll();
              },
              child: Text('clear Posts'),
            ),
            IconButton(
              icon: Icon(EvilIcons.arrow_up),
              onPressed: () {},
              iconSize: 100,
            )
          ],
        ),
      ),
    );
  }
}
