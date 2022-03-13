
import 'dart:typed_data';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/shared/cubit/BlocObserver.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'layout/home.dart';

void main() {
  Bloc.observer = MyBlocObserver();
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
  //cubit.get(context).notificationinitlization();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: home(),

    );
  }
}