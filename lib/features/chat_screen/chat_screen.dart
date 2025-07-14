import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_manager/config/theme.dart';
import 'package:work_manager/features/common_widgets/custom_text_field.dart';
import 'package:work_manager/features/fragments/chat_controller.dart';

import '../../services/cubit/onMessageCubit.dart';
import '../../services/socket_service.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key,required this.socketId,required this.title});
  final String title,socketId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("${widget.title}"),),

    body: Container(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Column(
        children: [
          //
          Expanded(
            child: BlocBuilder<OnMsgCubit,MsgState>(
                bloc: OnMsgCubit.instance,
                builder: (BuildContext context,MsgState state){
                  if(state is MsgReceiveState){

                    MessageModel.listMsgModel.add(MessageModel(msg: "${jsonDecode(state.msg)['msg']}",
                        isSelf: state.isSelf));
                    return ListView.separated(itemBuilder:(BuildContext context,int index){

                      return ListTile(
                        tileColor:MessageModel.listMsgModel[index].isSelf?
                        AppColors.orange:AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: AppColors.darkGray)
                        ),
                        title: Text("${MessageModel.listMsgModel[index].msg}"),);
                    },
                    separatorBuilder: (BuildContext context,int index){
                    return  SizedBox(height: 10,);

                    },itemCount: MessageModel.listMsgModel.length,);
                  }

                  return Text("$state");
                }),
          )
      //     Expanded(child: ListView.separated(itemBuilder: (BuildContext context,int index){
      // return ListTile(shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(5),
      //
      //     side: BorderSide(color: AppColors.darkGray)),
      //   title: Text("dsfkljsdkl"),
      // );
      //     },
      //
      //         separatorBuilder: (BuildContext context,int index){
      //           return SizedBox(height: 5,);
      //         }, itemCount: 10)),
,
CustomTextField(suffix: IconButton(onPressed: (){
  OnMsgCubit.instance.onMessageReceive(jsonEncode({"msg": ChatController.chatController.text,"to":"to"}),true);

  SocketService.instance.sendMessage("${ChatController.chatController.text}","${widget.socketId}" );

  ChatController.chatController.clear();
  }, icon: Icon(Icons.send,color: AppColors.orange,)), textController: ChatController.chatController,)
        ],
      ),
    ),);
  }


}
class MessageModel{
  String msg;
  bool isSelf;

  MessageModel({required this.msg,required this.isSelf});
  static List<MessageModel> listMsgModel=[];
}