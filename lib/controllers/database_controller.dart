import 'package:sqflite/sqflite.dart';

List<Map> tasks = [];

Database? db;
Future<void> createDatabase() async {
  db = await openDatabase('todo.db', version: 1,
      onCreate: (Database db, int version) async {
    // When creating the db, create  the table
    print('db created');
    await db
        .execute(
            'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT,time TEXT,status TEXT)')
        .then((value) => print('table created successfully'))
        .catchError((onError) =>
            print('error when creating table: ${onError.toString()}'));
  }, onOpen: (db) {
    print('db opened');
    getDataFromDB(db).then((value) {
      tasks = value;
      print(tasks);
    });
  });
}

Future<void> insertDatabase({
  required String name,
  required String date,
  required String time,
}) async {
  return await db?.transaction((txn) async {
    txn
        .rawInsert(
            'INSERT INTO Tasks(title, date, time, status) VALUES("$name", "$date", "$time", "new")')
        .then((value) => print('inserted successfully'))
        .catchError(
            (onError) => print('error when inserting: ${onError.toString()}'));
  });
}

Future<List<Map>> getDataFromDB(db) async {
  return await db.rawQuery('SELECT * FROM Tasks');
}

void updateDataToDB(
    {required String title,
    required int id,
    required String date,
    required String time,
    required String status}) async {
  await db?.rawUpdate(
      'UPDATE Tasks SET title = ?, date = ?, time = ?,status = ?, WHERE id = ?',
      ['$title', '$date', '$time', '$status', id]);
}

void deleteFromDB({required int id}) {
  db?.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]);
}
