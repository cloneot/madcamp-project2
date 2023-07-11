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

  //방 생성 emit (done)
  void createRoom(String roomName, String nickName) {
    if(roomName.isNotEmpty) {
      _socketClient.emit('createRoom', {'roomName': roomName, 'nickName': nickName});
    }
  }

  //방 참여 emit
  void joinRoom(String nickName, String roomId) {
    if(nickName.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'nickName': nickName,
        'roomId': roomId,
      });
    }
  }

  //TODO 채팅 내용 emit
  void enterChat(String chat, dynamic room) {
    if(chat.isNotEmpty) {
      _socketClient.emit('enterChat', {
        'chat': chat,
        'room': room,
      });
    }
  }

  //잘못된 roomId로 join on (done)
  void wrongRoomIdListener(BuildContext context) {
    _socketClient.on('wrongRoomId', (msg){
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    });
  }

  //방에 자리가 없음 on
  void noRoomSpaceListener(BuildContext context) {
    _socketClient.on('noRoomSpace', (msg){
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    });
  }

  //join할 room 정보 on
  void joinThisRoomListener(BuildContext context) {
    _socketClient.on('joinThisRoom', (room) {
      Provider.of<RoomDataProvider>(context, listen: false).updateRoomData(room);
      Provider.of<RoomDataProvider>(context, listen: false).setMePlayer(room.space);
      //TODO 참가자 게임 대기화면으로 바꾸기
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  //새 참가지 on
  void newPlayerListener(BuildContext context) {
    _socketClient.on('newPlayer', (nickName) {
      Provider.of<RoomDataProvider>(context, listen: false).newPlayer(nickName);
    });
  }

  //방 생성 성공 on (done)
  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on('createRoomSuccess', (newRoom) {
      Provider.of<RoomDataProvider>(context, listen: false).updateRoomData(newRoom);
      Fluttertoast.showToast(
          msg: newRoom.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      //TODO 방장 게임 대기화면으로 바꾸기
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  //TODO 정답 맞춤 on
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

  //TODO wrongAnswerListener 짜기 (optional)
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
   */

}