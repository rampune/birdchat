import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_manager/config/extensions.dart';
import 'package:work_manager/features/common_widgets/custom_text_field.dart';
import 'package:work_manager/features/fragments/chat_controller.dart';
import 'package:work_manager/services/cubit/onMessageCubit.dart';

import '../../services/cubit/userCubit.dart';
import '../../services/socket_service.dart';
class ChatFragment extends StatelessWidget {
  const ChatFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(onPressed: (){
        SocketService().connect();

      }, child: Text("Connect")),
      ElevatedButton(onPressed: (){
        // SocketService().sendMessage("hello");

      }, child: Text("send message")),
      10.height(),


      Text(""),
      CustomTextField(textController: ChatController.chatController),
      Expanded(
        child: BlocBuilder<UserCubit,UserState>(
            bloc: UserCubit.instance,
            builder: (BuildContext context,UserState state){
              if(state is UserListAvailableState){
                return ListView.builder(itemBuilder: (BuildContext context,int index){

                  return ListTile(
                    onTap: (){
SocketService.instance.sendMessage("${ChatController.chatController.text}","${state.userList[index]['id']}" );
                    },
                    title: Text("${state.userList[index]['name']}"),);

                }
                  ,itemCount: state.userList.length,
                );
              }

              return Text("$state");
            }),
      ),

      Expanded(
        child: BlocBuilder<OnMsgCubit,MsgState>(
            bloc: OnMsgCubit.instance,
            builder: (BuildContext context,MsgState state){
              if(state is MsgReceiveState){
                return Text("Msg ${state.msg}");
              }

              return Text("$state");
            }),
      ),
    ],);
  }
}
