
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/componants/componants.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class Tasks extends StatelessWidget  {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<cubit,states>(
        listener: (BuildContext context,states state){},
        builder: (BuildContext context,states state){
          cubit cub=cubit.get(context);
          return Dismissible(
            key: Key('0'),
            onDismissed: (direction){
              if(direction == DismissDirection.startToEnd){
                cubit.get(context).changeindex(cubit.get(context).cruntindex + 2 );
              }
              else{
                cubit.get(context).changeindex(cubit.get(context).cruntindex + 1 );
              }

            },
            child: ConditionalBuilder(
              condition:cub.new_tasks.length>0 ,
              builder: (context) =>ListView.separated(
                itemBuilder: (BuildContext context, int index) => itemnewtask(cub.new_tasks[index],context),
                itemCount: cub.new_tasks.length,
                separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10,)

              ),
              fallback: (context) => Center(child: Image(image: AssetImage('images/Add tasks-amico.png'),)),

            ),
          );
        },

    );
  }
}

