import 'package:flutter/material.dart';

class RoomListProvider extends ChangeNotifier {
  List<dynamic> _roomList = [];
  // roomId, roomName, owner
  // 가능하면 watingPlayers 추가
  List<dynamic> get roomList => _roomList;
  int get roomCnt => _roomList.length;

  void updateRoomList(List<dynamic> list) {
    print('client: room_list_provider: updateRoomList: $list');
    _roomList = list.where((e) => e['isStart'] == 0).toList();
    notifyListeners();
  }

  // void addRoom(dynamic data) {
  //   // createRoom
  //   dynamic pre = {
  //     'id': data['id'],
  //     'name': data['name'],
  //     'owner': data['owner']
  //   };
  //   print('id: ${pre['id']}');
  //   print('name: ${pre['name']}');
  //   print('owner: ${pre['owner']}');
  //   roomList.add(pre);
  //   notifyListeners();
  // }

  // void removeRoom(dynamic data) {
  //   // startGame
  //   // 방장이 나갔을 때
  //   roomList.remove(data);
  //   notifyListeners();
  // }
}
