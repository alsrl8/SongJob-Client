import 'package:path/path.dart';
import 'package:song_job/models/job_post.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;
  static const tableFavoriteJobPosts = 'favorite_jobs';

  static const columnLink = 'link';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initializeDatabase();
    return _database!;
  }

  _initializeDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $tableFavoriteJobPosts (
        name TEXT NOT NULL,
        company TEXT NOT NULL,
        techniques TEXT,
        location TEXT,
        career TEXT,
        link TEXT NOT NULL PRIMARY KEY,
        recruitmentSite TEXT
      )''');
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(tableFavoriteJobPosts);
  }

  Future<void> addToFavorite(JobPost jobPost) async {
    var db = await instance.database;
    await db.insert(tableFavoriteJobPosts, jobPost.toMap());
  }

  Future<void> removeFavorite(JobPost jobPost) async {
    var db = await instance.database;
    await db.delete(
      tableFavoriteJobPosts,
      where: '$columnLink = ?',
      whereArgs: [jobPost.link],
    );
  }

  Future<bool> isFavorite(JobPost jobPost) async {
    var db = await instance.database;
    var result = await db.query(
      tableFavoriteJobPosts,
      where: '$columnLink = ?',
      whereArgs: [jobPost.link],
    );
    return result.isNotEmpty;
  }
}
