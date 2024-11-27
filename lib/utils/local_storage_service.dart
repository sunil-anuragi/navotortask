import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/post_model.dart';

class LocalStorageService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'posts.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE posts(id INTEGER PRIMARY KEY, title TEXT, body TEXT, isRead INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<List<Post>> loadPosts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('posts');

    return List.generate(maps.length, (i) {
      return Post(
        id: maps[i]['id'],
        title: maps[i]['title'],
        body: maps[i]['body'],
      );
    });
  }

  Future<void> savePosts(List<Post> posts) async {
    final db = await database;
    for (var post in posts) {
      await db.insert(
        'posts',
        post.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> markAsRead(int postId) async {
    final db = await database;
    await db.update(
      'posts',
      {'isRead': 1},
      where: 'id = ?',
      whereArgs: [postId],
    );
  }
}
