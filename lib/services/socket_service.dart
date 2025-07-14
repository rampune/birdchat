import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:work_manager/services/cubit/onMessageCubit.dart';
import 'package:work_manager/services/cubit/userCubit.dart';

import '../data/source/local/hive_box.dart';

class SocketService {
  SocketService._private();
  static SocketService instance=SocketService._private();
  factory SocketService()=>instance;
  late IO.Socket socket;
  Future<void> connect() async {
    socket = IO.io(
      'http://192.168.1.37:3000',
      IO.OptionBuilder()
          .setTransports(['websocket'])

          .setQuery({
        'username': MyHiveBox.instance.getBox().get("login",defaultValue: null)
      })
          .build(),

    );

    socket.connect();

    socket.onConnect((_) {
      print('Connected to server: ${socket.id}');
    });

    socket.on('chat message', (data) {
      OnMsgCubit.instance.onMessageReceive(data,false);
      print('Received message: $data');
    });
    socket.on('user:list',(data){
      print("data is ${data['users']}");
      List<dynamic> userList=data['users'];
      UserCubit().onUserList(userList);

    });

    socket.onDisconnect((_) {
      UserCubit.instance.onUserInit();
      print('Disconnected');
    });
  }

  void sendMessage(String message,String socketId) {
    if (socket.connected) {
      socket.emit('chat message', jsonEncode({"msg":message,"to":socketId}));
    } else {
      print("Socket is not connected yet.");
    }
  }

  void disconnect() {
    socket.disconnect();
  }
}
