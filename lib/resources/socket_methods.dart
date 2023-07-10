import 'package:flutter/material.dart';
import 'package:madcamp_project2/provider/room_data_provider.dart';
import 'package:madcamp_project2/resources/socket_client.dart';
import 'package:madcamp_project2/screens/game_screen.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;
  Socket get socketClient => _socketClient;

  //방 생성 emit
  void createRoom(String roomName) {
    if(roomName.isNotEmpty) {
      _socketClient.emit('createRoom', { 'roomName': roomName});
    }
  }

  //방 참여 emit
  void joinRoom(String nickName, String roomId) {
    if(nickName.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'nickName': nickName,
        'roomId': roomId
      });
    }
  }

  //채팅 내용 emit
  void enterChat(String chat, dynamic room) {
    if(chat.isNotEmpty) {
      _socketClient.emit('enterChat', {
        'chat': chat,
        'room': room,
      });
    }
  }

  //방 생성 성공 on
  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on('createRoomSuccess', (newRoom) {
      //Provider.of<RoomDataProvider>(context, listen: false).updateRoomData(newRoom);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  //정답 맞춤 on
  void youWinListener(BuildContext context) {
    _socketClient.on('youWin', (_) {
      Fluttertoast.showToast(
          msg: "YOU WIN!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      //정답 맞춘 뒤 상황 추가
    });
  }

  //정답 틀림 on
//정답 틀림 on
//정답 틀림 on
//정답 틀림 on
//정답 틀림 on
//정답 틀림 on//정답 틀림 on
//정답 틀림 on
//정답 틀림 on
//정답 틀림 on
//정답 틀림 on
  /*
  void wrongAnswerListener(BuildContext context) {
    _socketClient.on('wrongAnswer', (difference, chat) => {
      Fluttertoast.showToast(
          msg: "YOU WIN!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    });
  }
  //정답 틀림 on
  //정답 틀림 on
  //정답 틀림 on
  //정답 틀림 on
  //정답 틀림 on
  //정답 틀림 on
   */

}