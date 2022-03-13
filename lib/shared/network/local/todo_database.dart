//
// import 'package:sqflite/sqflite.dart';
// import 'package:todo/shared/componants/constsnts.dart';
//
// class TodoDatabase
// {
//   late Database database;
//   String path='TODOAPPdata.db';
//   void create()async
//   {
//      database = await openDatabase(
//        path,
//       version:1,
//       onCreate: (database,version)
//       {
//         // teble 1////// id integer// title TEXT// date TEXT// time TEXT// status TEXT
//         print('database created');
//         database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY ,title TEXT,date TEXT,time TEXT,status TEXT)').then((value) {
//           print('table created');
//         }).catchError((error){
//           print('ERROR ${error.toString()}');
//         });
//       },
//       onOpen: (database)async
//       {
//         new_tasks= await get(database);
//
//
//       },
//     );
//   }
//
//    Future insert({
//      required String taskname,
//      required String taskdate,
//      required String tasktime,
//    })async
//   {
//     return await database.transaction( (txn)
//      {
//       return txn.rawInsert(
//         'INSERT INTO tasks(title,date,time,status) VALUES("$taskname","$taskdate","$tasktime","NEW")'
//       ).then((value)
//       {
//         print('$value insert successfully');
//       }).catchError((error)
//       {
//         print('Error!!!!!! ${error.toString()}');
//       });
//     });
//   }
//
//   Future<List<Map>> get(Database database)async
//   {
//     return await database.rawQuery("SELECT * FROM tasks");
//   }
// }
