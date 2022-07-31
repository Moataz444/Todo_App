import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

List<Map> ongoingTasks = [];
List<Map> doneTasks = [];
List<Map> archivedTasks = [];
Map tasksDB = {
  'new': 'NewTasks',
  'done': 'DoneTasks',
  'archived': 'ArchivedTasks',
};

// var db = openDatabase('todo.db');
class DatabaseController extends GetxController {
  Database? db;

  Future<void> createDatabase() async {
    db = await openDatabase('todo.db', version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create  the table
      print('db created');
      await db
          .execute(
              'CREATE TABLE NewTasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT,time TEXT, status TEXT, details TEXT)')
          .then((value) => print('OngoingTasks table created successfully'))
          .catchError((onError) => print(
              'error when creating OngoingTasks table: ${onError.toString()}'));
      await db
          .execute(
              'CREATE TABLE DoneTasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT,time TEXT, status TEXT, details TEXT)')
          .then((value) => print('DoneTasks table created successfully'))
          .catchError((onError) => print(
              'error when creating DoneTasks table: ${onError.toString()}'));
      await db
          .execute(
              'CREATE TABLE ArchivedTasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT,time TEXT, status TEXT, details TEXT)')
          .then((value) => print('ArchivedTasks table created successfully'))
          .catchError((onError) => print(
              'error when creating ArchivedTasks table: ${onError.toString()}'));
    }, onOpen: (db) {
      print('db opened');
      getDataFromDB(db);
    });
  }

  Future<List<Map>> getDataFromDB(db) async {
    ongoingTasks = [];
    doneTasks = [];
    archivedTasks = [];
    await db.rawQuery('SELECT * FROM ${tasksDB['new']}').then((value) {
      ongoingTasks = value;
    });
    await db.rawQuery('SELECT * FROM ${tasksDB['done']}').then((value) {
      doneTasks = value;
    });
    await db.rawQuery('SELECT * FROM ${tasksDB['archived']}').then((value) {
      archivedTasks = value;
      update();
    });
    return archivedTasks;
// value.forEach((taskItem) {
    //   if (taskItem['status'] == 'new') {
    //     ongoingTasks.add(taskItem);
    //   } else if (taskItem['status'] == 'done') {
    //     doneTasks.add(taskItem);
    //   } else {
    //     archivedTasks.add(taskItem);
    //   }
    // });

    // print(tasks);
  }

  Future<void> insertDatabase({
    required String details,
    required String status,
    required String title,
    required String date,
    required String time,
  }) async {
    return await db?.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO ${tasksDB[status]}(title, date, time, status, details) VALUES("$title", "$date", "$time", "$status", "$details")')
          .then((value) {
        print(
            'inserted successfully: "$title", "$date", "$time", "$status", "$details" ');
        // toaster('Task inserted successfully');

        update();
      }).catchError((onError) =>
              print('error when inserting: ${onError.toString()}'));
    });
  }

  void updateDataToDB({
    bool isSameTable = true,
    String oldStatus = '',
    required String title,
    required int id,
    required String date,
    required String time,
    required String status,
    required String details,
  }) async {
    if (isSameTable) {
      await db?.rawUpdate(
          'UPDATE ${tasksDB[status]} SET title = ?, date = ?, time = ?,status = ?,details = ? WHERE id = ?',
          [title, date, time, status, details, id]).then((value) {
        print('updated successfully');
        // update();
      });
    } else {
      insertDatabase(
          details: details,
          status: status,
          title: title,
          date: date,
          time: time);
      deleteFromDB(id: id, status: oldStatus);
    }
    // toaster('Task updated successfully');

    getDataFromDB(db);
  }

  void deleteFromDB({
    required int id,
    required String status,
  }) {
    db?.rawDelete('DELETE FROM ${tasksDB[status]} WHERE id = ?', [id]).then(
        (value) {
      print('deleted successfully');
      // toaster('Task deleted successfully');
      update();
    });
  }
}
