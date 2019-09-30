// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _PostBean implements Bean<Post> {
  final id = IntField('id');
  final msg = StrField('msg');
  final read = BoolField('read');
  final stars = DoubleField('stars');
  final at = DateTimeField('at');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        msg.name: msg,
        read.name: read,
        stars.name: stars,
        at.name: at,
      };
  Post fromMap(Map map) {
    Post model = Post();
    model.id = adapter.parseValue(map['id']);
    model.msg = adapter.parseValue(map['msg']);
    model.read = adapter.parseValue(map['read']);
    model.stars = adapter.parseValue(map['stars']);
    model.at = adapter.parseValue(map['at']);

    return model;
  }

  List<SetColumn> toSetColumns(Post model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(msg.set(model.msg));
      ret.add(read.set(model.read));
      ret.add(stars.set(model.stars));
      ret.add(at.set(model.at));
    } else if (only != null) {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(msg.name)) ret.add(msg.set(model.msg));
      if (only.contains(read.name)) ret.add(read.set(model.read));
      if (only.contains(stars.name)) ret.add(stars.set(model.stars));
      if (only.contains(at.name)) ret.add(at.set(model.at));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.msg != null) {
        ret.add(msg.set(model.msg));
      }
      if (model.read != null) {
        ret.add(read.set(model.read));
      }
      if (model.stars != null) {
        ret.add(stars.set(model.stars));
      }
      if (model.at != null) {
        ret.add(at.set(model.at));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, autoIncrement: true, isNullable: false);
    st.addStr(msg.name, isNullable: true);
    st.addBool(read.name, isNullable: true);
    st.addDouble(stars.name, isNullable: true);
    st.addDateTime(at.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Post model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      Post newModel;
    }
    return retId;
  }

  Future<void> insertMany(List<Post> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Post model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.upsert(upsert);
    if (cascade) {
      Post newModel;
    }
    return retId;
  }

  Future<void> upsertMany(List<Post> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
    }
    final UpsertMany upsert = upserters.addAll(data);
    await adapter.upsertMany(upsert);
    return;
  }

  Future<int> update(Post model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Post> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
      where.add(this.id.eq(model.id));
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<Post> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Post> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
