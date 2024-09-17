import 'package:exem_6/data/models/harajat_model.dart';
import 'package:sqflite/sqflite.dart';

class HarajatServices {
  static final HarajatServices _instance = HarajatServices._init();
  static Database? _harajatDatabase;

  HarajatServices._init();

  factory HarajatServices() {
    return _instance;
  }

  final getDatabase = getDatabasesPath();
  
  final path = "$getDatabasesPath/harajat.db";

  Future<Database> get harajatDatabase async {
    if (_harajatDatabase != null) {
      return _harajatDatabase!;
    }

    try {
      _harajatDatabase = await _initDB('harajad.db');
      return _harajatDatabase!;
    } catch (e) {
      print('Bazani ochishda xato: $e');
      rethrow;
    }
  }

  Future<Database> _initDB(String filePath) async {
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE harajatBase (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        summa REAL,
        category TEXT,
        sana TEXT,
        izoh TEXT
      )
    ''');
  }

  @override
  Future<void> addHarajat(HarajatModel harajat) async {
    final db = await harajatDatabase;
    try {
      await db.insert('harajatBase', harajat.toMap());
    } catch (e) {
      print('Harajat qo\'shishda xato: $e');
      print('Harajat ma\'lumotlari: ${harajat.toMap()}');
      rethrow;
    }
  }

  @override
  Future<List<HarajatModel>> getHarajat() async {
    final db = await harajatDatabase;
    try {
      final result = await db.query('harajatBase'); 
      return result.map((json) => HarajatModel.fromMap(json)).toList(); 
    } catch (e) {
      print('Eventlarni olishda xato: $e');
      rethrow;
    }
  }

  @override
  Future<void> editHarajat(HarajatModel harajat) async {
    final db = await harajatDatabase;
    try {
      await db.update(
        'harajatBase',
        harajat.toMap(),
        where: 'id = ?',
        whereArgs: [harajat.id],
      );
    } catch (e) {
      print('Eventni tahrirlashda xato: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteHarajat(int id) async {
    final db = await harajatDatabase;
    try {
      await db.delete(
        'harajatBase',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      // ignore: avoid_print
      print("Harajat o'chirishda xato: $e");
      rethrow;
    }
  }

  Future<void> checkTableStructure() async {
    final db = await harajatDatabase;
    var tableInfo = await db.rawQuery("PRAGMA table_info('harajatBase')");
    print('Jadval tuzilmasi: $tableInfo');
  }
}
