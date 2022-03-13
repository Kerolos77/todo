import 'dart:typed_data';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/modules/archived.dart';
import 'package:todo/modules/done.dart';
import 'package:todo/modules/tasks.dart';
import 'package:todo/shared/componants/constsnts.dart';
import 'package:todo/shared/cubit/states.dart';

class cubit extends Cubit<states> {
  cubit() : super(InitialState());

  static cubit get(context) => BlocProvider.of(context);

  int cruntindex = 0;

  List<Widget> screens = [Tasks(), done(), archived()];

  List<String> apptitle = ["NewTasks", "DoneTasks", "ArchivedTasks"];

  late Database database;

  String path = 'TODOAPPData.db';

  List<Map> new_tasks = [];
  List<Map> done_tasks = [];
  List<Map> archive_tasks = [];

  bool fbflag = false;

  IconData fbicon = Icons.edit;

  int year = 0;
  int month = 0;
  int day = 0;
  int hour = 0;
  int minute = 0;
  void changeindex(int index) {
    cruntindex = index;
    emit(ChangeBottonmNavBarstate());
  }

  void create() {
    openDatabase(
      path,
      version: 1,
      onCreate: (database, version) {
        // teble 1////// id integer// title TEXT// date TEXT// time TEXT// status TEXT
        print('database created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY ,title TEXT,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('ERROR ${error.toString()}');
        });
      },
      onOpen: (database) {
        getdata(database);
      },
    ).then((value) {
      database = value;
      emit(CreatDataBaseState());
    });
  }

  insert({
    required String taskname,
    required String taskdate,
    required String tasktime,
  }) async {
    await database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES("$taskname","$taskdate","$tasktime","new")')
          .then((value) {
        print('$value insert successfully');
        emit(InsertDataBaseState());
        notification(title: taskname, body: '$tasktime ''/n'' $taskdate', id: 1);
        print(date());
        getdata(database);
      }).catchError((error) {
        print('Error!!!!!! ${error.toString()}');
      });
    });
  }

  void getdata(Database database) {
    new_tasks = [];
    done_tasks = [];
    archive_tasks = [];
    emit(GetDataBaseloadingState());
    database.rawQuery("SELECT * FROM tasks").then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          new_tasks.add(element);
        else if (element['status'] == 'done')
          done_tasks.add(element);
        else
          archive_tasks.add(element);
      });

      emit(GetDataBaseState());
    });
  }

  void update({
    required String status,
    required int id,
  }) async {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getdata(database);
      emit(UpDateDataBaseState());
    });
  }

  void delete({
    required int id,
  }) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', ['$id']).then((value) {
      getdata(database);
      emit(DeleteDataBaseState());
    });
  }

  void changeBottomSheetState({
    required bool isshow,
    required IconData icon,
  }) {
    fbflag = isshow;
    fbicon = icon;
    emit(ChangeButtomSheetState());
  }

  DateTime date() {
    return DateTime.utc(year, month, day, hour, minute,0,0,0);
  }

  void notificationinitlization(){
    AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
            channelKey: 'scheduled',
            channelName: 'ToDo',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Colors.cyan,
            ledColor: Colors.white,
            playSound: true,

            enableVibration: true,
            vibrationPattern: Int64List.fromList([10000, 1000, 200, 200]),
          )
        ]
    );
  }

  void notification({
    required String title,
    required String body,
    required int id,

  })async{
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: 'scheduled',
          title: title,
          body: body,
          autoCancel: false,
        ),
        schedule: NotificationCalendar.fromDate(date: date())
    );
  }
}
