import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:madcamp_project2/models/player.dart';

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

  int? get mePlayer => _mePlayer;
  dynamic get roomData => _roomData;
  /*
  Player? get player1 => _player1;
  Player? get player2 => _player2;
  Player? get player3 => _player3;
  Player? get player4 => _player4;
   */


  void updateRoomData(dynamic data) {
    _roomData = data;
    notifyListeners();
  }

  void setMePlayer(int leftSpace) {
    _mePlayer = 4-leftSpace;
    notifyListeners();
  }

  void newPlayer(String nickName) {
    if(_roomData.space==3) {
      _roomData.player2 == nickName;
      _roomData.place--;
      notifyListeners();
      return;
    }
    if(_roomData.space==2) {
      _roomData.player3 == nickName;
      _roomData.place--;
      notifyListeners();
      return;
    }
    if(_roomData.space==1) {
      _roomData.player4 == nickName;
      _roomData.place--;
      notifyListeners();
      return;
    }
    notifyListeners();
    return;
  }
}