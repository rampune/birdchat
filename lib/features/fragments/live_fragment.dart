import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_manager/config/extensions.dart';
import 'package:work_manager/config/theme.dart';
import 'package:work_manager/features/chat_screen/chat_screen.dart';

import '../../services/cubit/userCubit.dart';
import '../../services/socket_service.dart';
import 'chat_controller.dart';
class LiveFragment extends StatefulWidget {
  const LiveFragment({super.key});

  @override
  State<LiveFragment> createState() => _LiveFragmentState();
}

class _LiveFragmentState extends State<LiveFragment> {
  @override
  void initState() {
    SocketService().connect();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit,UserState>(
        bloc: UserCubit.instance,
        builder: (BuildContext context,UserState state){
          if(state is UserListAvailableState){
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: ListView.separated(

                itemBuilder: (BuildContext context,int index){

              return ListTile(
                leading: Icon(Icons.account_circle,color: AppColors.themeColor,size: 35,),
                trailing: Icon(Icons.message,color: AppColors.orange,),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: AppColors.black)
                ),
                onTap: (){

                  Navigator.push(context, MaterialPageRoute(builder: (_)=>
                      ChatScreen(socketId: state.userList[index]['id'], title: "+91 ${state.userList[index]['name']}")));

                },
                title: Text("+91 ${state.userList[index]['name']}",
                textAlign: TextAlign.center,
                style: context.titleSmall()?.copyWith(fontWeight: FontWeight.bold,
                ),),);

            }
              ,itemCount: state.userList.length,
                separatorBuilder: (BuildContext context,int index){
                  return SizedBox(height: 20,);
                },
            ),);
          }

          return Text("$state");
        });
  }
}
