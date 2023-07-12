import 'package:flutter/material.dart';
import 'package:madcamp_project2/models/chat_message.dart';
import 'package:madcamp_project2/provider/chat_data_provider.dart';
import 'package:madcamp_project2/provider/room_data_provider.dart';
import 'package:madcamp_project2/resources/socket_client.dart';
import 'package:madcamp_project2/screens/game_screen.dart';
import 'package:madcamp_project2/screens/game_waiting_room.dart';
import 'package:madcamp_project2/screens/main_menu_screen.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../provider/room_list_provider.dart';
import 'dart:async';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;
  Socket get socketClient => _socketClient;
  Timer? timer;

  //방 생성 emit (done)
  void createRoom(String roomName, String nickName) {
    if (roomName.isNotEmpty && nickName.isNotEmpty) {
      _socketClient
          .emit('createRoom', {'roomName': roomName, 'nickName': nickName});
    }
  }

  //방 참여 emit
  void joinRoom(String nickName, String roomId) {
    if (nickName.isNotEmpty && roomId.isNotEmpty) {
      print('joinRoom emit: nickName: $nickName, roomId: $roomId');
      _socketClient.emit('joinRoom', {
        'nickName': nickName,
        'roomId': roomId,
      });
    }
  }

  //game start request emit
  void gameStart(String nickName, String roomId) {
    if (nickName.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('gameStart', {
        'nickName': nickName,
        'roomId': roomId,
      });
    }
  }

  //TODO 채팅 내용 emit
  void enterChat(String chat, dynamic room, String? myNickName) {
    if (chat.isNotEmpty) {
      print('client: enterChat emit myNickName: $myNickName');
      _socketClient.emit('enterChat', {
        'chat': chat,
        'room': room,
        'myNickName': myNickName,
      });
    }
  }

  //참가자가 대기화면 나감
  void playerLeaveWaitingRoom(BuildContext context) {
    _socketClient.emit('playerLeaveWaitingRoom', {
      'room': Provider.of<RoomDataProvider>(context, listen: false).roomData,
      'mePlayer':
          Provider.of<RoomDataProvider>(context, listen: false).mePlayer,
    });
    Provider.of<RoomDataProvider>(context, listen: false).clearRoomData();
  }

  //방장이 대기화면 나감
  void ownerLeaveWaitingRoom(BuildContext context) {
    _socketClient.emit('ownerLeaveWaitingRoom',
        Provider.of<RoomDataProvider>(context, listen: false).roomData);
    Provider.of<RoomDataProvider>(context, listen: false).clearRoomData();
  }

  //잘못된 enterChat 방 id or 방 name
  void roomDataErrorListener(BuildContext context) {
    _socketClient.off('roomDataError');
    _socketClient.on('roomDataError', (_) {
      Fluttertoast.showToast(
          msg: 'roomDataError',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  //존재하지 않는 영어단어
  void noSuchWordListener(BuildContext context) {
    _socketClient.off('noSuchWord');
    _socketClient.on('noSuchWord', (data) {
      Fluttertoast.showToast(
          msg: '$data는 없는 단어입니다.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  //참가자 대기화면 나감 from server
  void playerLeaveWaitingRoomFromServerListener(BuildContext context) {
    _socketClient.off('playerLeaveWaitingRoomFromServer');
    _socketClient.on('playerLeaveWaitingRoomFromServer', (room) {
      print('playerLeaveWaitingRoomFromServerListener: $room');
      // Provider.of<RoomDataProvider>(context, listen: false).setMePlayer(room.space);
      Provider.of<RoomDataProvider>(context, listen: false).updateRoomData(room);
    });
  }

  //게임 시작 허용 (방장)
  void gameStartAllowListener(BuildContext context) {
    _socketClient.off('gameStartAllow');
    _socketClient.on('gameStartAllow', (_) {
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  //게임 시작 reject (참가자)
  void youAreNotOwnerListener(BuildContext context) {
    _socketClient.off('youAreNotOwner');
    _socketClient.on('youAreNotOwner', (_) {
      Fluttertoast.showToast(
          msg: '방장이 아닙니다.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  //잘못된 roomId로 join on (done)
  void wrongRoomIdListener(BuildContext context) {
    _socketClient.off('wrongRoomId');
    _socketClient.on('wrongRoomId', (msg) {
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  //방에 자리가 없음 on
  void noRoomSpaceListener(BuildContext context) {
    _socketClient.off('noRoomSpace');
    _socketClient.on('noRoomSpace', (msg) {
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  //방장이 대기화면 떠남
  void waitingRoomExplodeListener(BuildContext context) {
    _socketClient.off('waitingRoomExplode');
    _socketClient.on('waitingRoomExplode', (_) {
      _socketClient.emit('leaveRoom',
          Provider.of<RoomDataProvider>(context, listen: false).roomData);
      Provider.of<RoomDataProvider>(context, listen: false)
          .setIsExplodeByOwner(true);
      Provider.of<RoomDataProvider>(context, listen: false).clearRoomData();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainMenuScreen()),
          (route) => false);
    });
  }

  //join할 room 정보 on
  void joinThisRoomListener(BuildContext context) {
    _socketClient.off('joinThisRoom');
    _socketClient.on('joinThisRoom', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      print('joinThisRoom listener: space: ${room['space']}');
      Provider.of<RoomDataProvider>(context, listen: false)
          .setMePlayer(context);
      //TODO 참가자 게임 대기화면으로 바꾸기
      Navigator.pushNamed(context, GameWaitingRoomScreen.routeName);
    });
  }

  //새 참가지 on
  void newPlayerListener(BuildContext context) {
    _socketClient.off('newPlayer');
    _socketClient.on('newPlayer', (nickName) {
      print('newPlayer listener: $nickName');
      Provider.of<RoomDataProvider>(context, listen: false).newPlayer(nickName);
    });
  }

  //방 생성 성공 on (done)
  void createRoomSuccessListener(BuildContext context) {
    _socketClient.off('createRoomSuccess');
    _socketClient.on('createRoomSuccess', (newRoom) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(newRoom);
      Provider.of<RoomDataProvider>(context, listen: false)
          .setMePlayer(context);
      Navigator.popAndPushNamed(context, GameWaitingRoomScreen.routeName);
    });
  }

  //TODO 정답 맞춤 on
  void someoneWinListener(BuildContext context) {
    _socketClient.off('someoneWin');
    _socketClient.on('someoneWin', (data) {
      _socketClient.emit('leaveRoom',
          Provider.of<RoomDataProvider>(context, listen: false).roomData);
      Provider.of<RoomDataProvider>(context, listen: false).clearRoomData();
      Fluttertoast.showToast(
          msg: "$data WIN!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      //정답 맞춘 뒤 상황 추가
      Provider.of<ChatDataProvider>(context, listen: false).clearChatMessage();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainMenuScreen()),
          (route) => false);
    });
  }

  //TODO wrongAnswerListener 짜기
  void wrongAnswerListener(BuildContext context) {
    _socketClient.off('wrongAnswer');
    _socketClient.on('wrongAnswer', (data) {
      print('wrongAnswerListener: $data');
      Provider.of<ChatDataProvider>(context, listen: false)
          .addChatMessage(ChatMessage(
        message: data['chat'],
        messageScore: data['difference'],
        sendingPlayer: data['myNickName'],
      ));
    });
  }

  void getRoomList() {
    _socketClient.emit('getRoomList');
  }

  // 방 목록 success
  void getRoomListSuccessListener(BuildContext context) {
    _socketClient.off('getRoomListSuccess');
    _socketClient.on('getRoomListSuccess', (roomList) {
      print('getRoomListListener success: $roomList');
      Provider.of<RoomListProvider>(context, listen: false)
          .updateRoomList(roomList);
    });
  }

  //타이머 시작 on
  void timerStartListener(BuildContext context) {
    _socketClient.off('timerStart');
    _socketClient.on('timerStart', (_) {
      timer?.cancel();
      Provider.of<RoomDataProvider>(context, listen: false).timer =
          Timer(const Duration(seconds: 11), () {
        _socketClient.emit('timeOver',
            Provider.of<RoomDataProvider>(context, listen: false).roomData);
      });
    });
  }

  //게임 시간 종료 on
  void timeOverFromServerListener(BuildContext context) {
    _socketClient.off('timeOverFromServer');
    _socketClient.on('timeOverFromServer', (data) {
      _socketClient.emit('leaveRoom',
          Provider.of<RoomDataProvider>(context, listen: false).roomData);
      Provider.of<RoomDataProvider>(context, listen: false).clearRoomData();
      Fluttertoast.showToast(
          msg: "${data['nickName']} is WINNER!!\nScore: ${data['score']}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Provider.of<ChatDataProvider>(context, listen: false).clearChatMessage();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainMenuScreen()),
          (route) => false);
    });
  }
}
