import 'package:add_notes_project/model/notesDataModel.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
 

    await db.execute('''
create table notesTable ( 
  columnId integer primary key autoincrement, 
  note text not null,
  date text not null)
  
''');
  }

  Future<Notes> create(Notes note) async {
    final db = await instance.database;

    final id = await db.insert('notesTable', note.toMap());
    return note.copyWith(columnId: id);
  }


  Future<List<Notes>> readAllNotes() async {
    final db = await instance.database;


    final result = await db.query('notesTable', orderBy:  'date ASC');

    return result.map((json) => Notes.fromMap(json)).toList();
  }

  Future<int> update(Notes note) async {
    final db = await instance.database;

    return db.update(
      'notesTable',
      note.toMap(),
      where: 'columnId = ?',
      whereArgs: [note.columnId],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      'notesTable',
      where: 'columnId = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}