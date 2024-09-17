import 'package:exem_6/data/models/harajat_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DaromadServices {
  static final DaromadServices _instance = DaromadServices._init();
  static Database? _daromadDatabase;

  DaromadServices._init();

  factory DaromadServices() {
    return _instance;
  }

  final getDatabase = getDatabasesPath();
  
  final path = "$getDatabasesPath/daromad.db";

  

  Future<Database> get daromadDatabase async {
    if (_daromadDatabase != null) {
      return _daromadDatabase!;
    }

    try {
      _daromadDatabase = await _initDB('daromad.db');
      return _daromadDatabase!;
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
      CREATE TABLE daromadBase (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        summa REAL,
        category TEXT,
        sana TEXT,
        izoh TEXT
      )
    ''');
  }

  @override
  Future<void> addDaromad(HarajatModel harajat) async {
    final db = await daromadDatabase;
    try {
      await db.insert('daromadBase', harajat.toMap());
    } catch (e) {
      print('Daromad qo\'shishda xato: $e');
      print('Daromad ma\'lumotlari: ${harajat.toMap()}');
      rethrow;
    }
  }

  @override
  Future<List<HarajatModel>> getDaromad() async {
    final db = await daromadDatabase;
    try {
      final result = await db.query('daromadBase'); 
      return result.map((json) => HarajatModel.fromMap(json)).toList(); 
    } catch (e) {
      print('Eventlarni olishda xato: $e');
      rethrow;
    }
  }

  @override
  Future<void> editDaromad(HarajatModel harajat) async {
    final db = await daromadDatabase;
    try {
      await db.update(
        'daromadBase',
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
  Future<void> deleteDaromad(int id) async {
    final db = await daromadDatabase;
    try {
      await db.delete(
        'daromadBase',
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
    final db = await daromadDatabase;
    var tableInfo = await db.rawQuery("PRAGMA table_info('daromadBase')");
    print('Jadval tuzilmasi: $tableInfo');
  }
}
