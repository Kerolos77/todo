
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/componants/componants.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class done extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return  BlocConsumer<cubit,states>(
      listener: (BuildContext context,states state){},
      builder: (BuildContext context,states state){
        cubit cub=cubit.get(context);
        return Dismissible(
          key: Key('1'),
          onDismissed: (direction){
            if(direction == DismissDirection.startToEnd){
              cubit.get(context).changeindex(cubit.get(context).cruntindex - 1 );
            }
            else{
              cubit.get(context).changeindex(cubit.get(context).cruntindex + 1 );
            }

          },
          child: ConditionalBuilder(
            condition:cub.done_tasks.length>0 ,
            builder: (context) =>ListView.separated(
              itemBuilder: (BuildContext context, int index) => itemdonetask(cub.done_tasks[index],context),
              itemCount: cub.done_tasks.length,
              separatorBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsetsDirectional.only(start: 20,end: 20),
                child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey
                ),
              ),

            ),
            fallback: (context) => Center(child: Image(image: AssetImage('images/Add tasks-amico.png'),)),

          ),
        );
      },

    );
  }
}