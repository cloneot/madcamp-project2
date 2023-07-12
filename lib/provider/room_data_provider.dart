import 'dart:async';

import 'package:flutter/material.dart';
import 'package:madcamp_project2/provider/user_data_provider.dart';
import 'package:provider/provider.dart';

class RoomDataProvider extends ChangeNotifier {
  /*
  Player? _player1;
  Player? _player2;
  Player? _player3;
  Player? _player4;
   */
  //roomId, roomName, owner
  dynamic _roomData;
  int? _mePlayer;
  bool? _isWaitingRoom;
  bool? _isExplodeByOwner;
  Timer? timer;

  bool? get isExplodeByOwner => _isExplodeByOwner;
  bool? get isWaitingRoom => _isWaitingRoom;
  int? get mePlayer => _mePlayer;
  dynamic get roomData => _roomData;
  // Timer get timer => _timer!;
  /*
  Player? get player1 => _player1;
  Player? get player2 => _player2;
  Player? get player3 => _player3;
  Player? get player4 => _player4;
   */
  void setIsStart(n) {
    _roomData['isStart'] = n;
  }
  void setIsWaitingRoom(b) {
    _isWaitingRoom = b;
  }

  void setIsExplodeByOwner(b) {
    _isExplodeByOwner = b;
  }

  void updateRoomData(dynamic data) {
    _roomData = data;
    notifyListeners();
  }

  void clearRoomData() {
    _roomData = null;
  }

  void setMePlayer(BuildContext context) {
    print('room_data_provier SetMePlayer');
    String? myNickName =
        Provider.of<UserDataProvider>(context, listen: false).username;
    if (_roomData['owner'] == myNickName) {
      _mePlayer = 1;
      return;
    }
    if (_roomData['player2'] == myNickName) {
      _mePlayer = 2;
      return;
    }
    if (_roomData['player3'] == myNickName) {
      _mePlayer = 3;
      return;
    }
    if (_roomData['player4'] == myNickName) {
      _mePlayer = 4;
      return;
    }
  }

  /*
  String? myNickName() {
    if (_mePlayer == 1) {
      return _roomData['owner'];
    }
    if (_mePlayer == 2) {
      return _roomData['player2'];
    }
    if (_mePlayer == 3) {
      return _roomData['player3'];
    }
    if (_mePlayer == 4) {
      return _roomData['player4'];
    }
    return null;
  }
   */

  void newPlayer(String nickName) {
    print('room_data_provider newPlayer() space: ${_roomData['space']}');
    if (_roomData['player2'] == '') {
      _roomData['player2'] = nickName;
      _roomData['space']--;
      notifyListeners();
      return;
    }
    if (_roomData['player3'] == '') {
      _roomData['player3'] = nickName;
      _roomData['space']--;
      notifyListeners();
      return;
    }
    if (_roomData['player4'] == '') {
      _roomData['player4'] = nickName;
      _roomData['space']--;
      notifyListeners();
      return;
    }
    notifyListeners();
    return;
  }
}
