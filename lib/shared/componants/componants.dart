import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:todo/shared/cubit/cubit.dart';

Widget dfulttextfilde({
  required TextEditingController control,
  required TextInputType type,
  required String lable,
  required IconData icon,
  bool enablekey=false,
  ValueChanged? onsubmit,
  ValueChanged? onchange,
  GestureTapCallback? ontape,
  FormFieldValidator? validatetor,
}) =>
    TextFormField(
      controller: control,
      keyboardType: type,
      onChanged: onchange,
      onTap:ontape ,
      validator:validatetor ,
      onFieldSubmitted: onsubmit,
      readOnly: enablekey,
      decoration: InputDecoration(
        labelText: lable,
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.black12,
        prefixIcon: /**/ Icon(
          icon,
          size: 20,
          color: Colors.white,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

Widget itemnewtask(Map model,context) =>
    Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction){
        cubit.get(context).delete(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.cyan,
                child: Text(
                  '${model['time']}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment:  MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model['title']}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${model['date']}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: (){
                  cubit.get(context).update(status: 'done', id: model['id']);
                },
                icon: Icon(
                  Icons.check_box,
                  color: Colors.greenAccent,
                ),
              ),

              IconButton(
                onPressed: (){
                  cubit.get(context).update(status: 'archive', id: model['id']);
                },
                icon: Icon(
                  Icons.archive,
                  color: Colors.black38,
                ),
              ),
            ],
          ),
        ),
      ),

    );

Widget itemdonetask(Map model,context) =>
    Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction){
        cubit.get(context).delete(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.cyan,
                child: Text(
                  '${model['time']}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment:  MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model['title']}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${model['date']}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: (){
                  cubit.get(context).update(status: 'new', id: model['id']);
                },
                icon: Icon(
                  Icons.menu,
                  color: Colors.black38,
                ),
              ),

              IconButton(
                onPressed: (){
                  cubit.get(context).update(status: 'archive', id: model['id']);
                },
                icon: Icon(
                  Icons.archive,
                  color: Colors.black38,
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget itemarchivetask(Map model,context) =>
    Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction){
        cubit.get(context).delete(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.cyan,
                child: Text(
                  '${model['time']}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment:  MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model['title']}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${model['date']}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: (){
                  cubit.get(context).update(status: 'done', id: model['id']);
                },
                icon: Icon(
                  Icons.check_box,
                  color: Colors.greenAccent,
                ),
              ),

              IconButton(
                onPressed: (){
                  cubit.get(context).update(status: 'new', id: model['id']);
                },
                icon: Icon(
                  Icons.menu,
                  color: Colors.black38,
                ),
              ),
            ],
          ),
        ),
      ),
    );