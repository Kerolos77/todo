
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/shared/componants/componants.dart';
import 'package:todo/shared/componants/constsnts.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';
class home extends StatelessWidget {

  TextEditingController tasknamecontrol = new TextEditingController();
  TextEditingController tasktimecontrol = new TextEditingController();
  TextEditingController taskdatecontrol = new TextEditingController();
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  int nowDateYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) =>cubit()..create(),
      child: BlocConsumer<cubit,states>(
        listener:(BuildContext context , states states){
          if(states is InsertDataBaseState ){
            Navigator.pop(context);
          }
        },
        builder:(BuildContext context , states states)
        {
          cubit cub=cubit.get(context);
          return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              title:Text(
                cub.apptitle[cub.cruntindex],
              ),
            ),
            body: ConditionalBuilder(
              condition:states is! GetDataBaseloadingState ,
              builder:(context)=> cub.screens[cub.cruntindex],
              fallback: (context)=> Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: Stack(
              children: [
                CircleAvatar(
                  radius: 24.5,
                  backgroundColor: Colors.white,
                ),
                FloatingActionButton(
                  elevation: 0,
                  onPressed: () {
                    if (cub.fbflag) {
                      if (formkey.currentState!.validate()) {

                        cub.insert(
                            taskname: tasknamecontrol.text,
                            taskdate: taskdatecontrol.text,
                            tasktime: tasktimecontrol.text
                        );
                      }
                    } else {
                      tasknamecontrol.text = "";
                      tasktimecontrol.text = "";
                      taskdatecontrol.text = "";
                      scaffoldkey.currentState!.showBottomSheet(
                            (context) => SingleChildScrollView(
                              child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Form(
                                  key: formkey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      dfulttextfilde(
                                          type: TextInputType.emailAddress,
                                          control: tasknamecontrol,
                                          icon: Icons.title,
                                          lable: 'Task Name',
                                          validatetor: (value) {
                                            if (value.isEmpty)
                                              return 'Task Name must not be empty';
                                            return null;
                                          }),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      dfulttextfilde(
                                          type: TextInputType.datetime,
                                          control: tasktimecontrol,
                                          icon: Icons.watch_later_outlined,
                                          lable: 'Task Time',
                                          enablekey: true,
                                          validatetor: (value) {
                                            if (value.isEmpty)
                                              return 'Task Time must not be empty';
                                            return null;
                                          },
                                          ontape: () {
                                            showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            ).then((value) {
                                              tasktimecontrol.text = value!
                                                  .format(context)
                                                  .toString();
                                              cubit.get(context).hour=value.hour;
                                              cubit.get(context).minute=value.minute;
                                            });
                                          }),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      dfulttextfilde(
                                          type: TextInputType.datetime,
                                          control: taskdatecontrol,
                                          icon: Icons.calendar_today_outlined,
                                          lable: 'Task Date',
                                          enablekey: true,
                                          validatetor: (value) {
                                            if (value.isEmpty)
                                              return 'Task Date must not be empty';
                                            return null;
                                          },
                                          ontape: () {
                                            showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime.parse('${nowDateYear+20}-01-01'),
                                            ).then((value) {
                                              taskdatecontrol.text = DateFormat.yMMMMd()
                                                  .format(value!)
                                                  .toString();
                                              cubit.get(context).year=value.year;
                                              cubit.get(context).month=value.month;
                                              cubit.get(context).day=value.day;
                                            });
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(0),
                                      topRight: Radius.circular(30),
                                      topLeft: Radius.circular(30)))),
                            ),
                      ).closed.then((value) {
                        cub.changeBottomSheetState(isshow: false, icon: Icons.edit);

                      });
                      cub.changeBottomSheetState(isshow: true, icon: Icons.add);
                    }
                  },
                  mini: true,
                  child: Icon(
                    cub.fbicon,
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex:cub.cruntindex,
                onTap: (index){
                  cub.changeindex(index);
                },
                items:[
                  BottomNavigationBarItem(
                      icon:Icon(Icons.menu),
                      label: 'New'
                  ),
                  BottomNavigationBarItem(
                      icon:Icon(Icons.check_circle_outline),
                      label: 'Done'
                  ),
                  BottomNavigationBarItem(
                      icon:Icon(Icons.archive_outlined),
                      label: 'Archive'
                  ),
                ]
            ),
          );
        } ,
      ),
    );
  }



}

