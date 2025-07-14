import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:work_manager/config/extensions.dart';
import 'package:work_manager/services/cubit/userCubit.dart';
import 'package:work_manager/services/socket_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SocketTest extends StatelessWidget {
  const SocketTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Column(children: [
      ElevatedButton(onPressed: (){
        SocketService().connect();

      }, child: Text("Connect")),
      ElevatedButton(onPressed: (){


      }, child: Text("send message")),
      10.height(),


      Text(""),
      BlocBuilder<UserCubit,UserState>(
          bloc: UserCubit.instance,
          builder: (BuildContext context,UserState state){
if(state is UserListAvailableState){
  return ListView.builder(itemBuilder: (BuildContext context,int index){

    return ListTile(title: Text("${state.userList[index]}"),);

  }
  ,itemCount: state.userList.length,
  );
}

        return Text("$state");
      }),
      SizedBox()

    ],),
    );
  }
}
