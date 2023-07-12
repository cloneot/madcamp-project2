import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../provider/room_data_provider.dart';
import '../resources/socket_methods.dart';

class Player {
  int userId;
  String username;
  int totalGames;
  int wins;
  int loses;
  int draws;

  Player({
    required this.userId,
    required this.username,
    required this.totalGames,
    required this.wins,
    required this.loses,
    required this.draws,
  });
}

class GameWaitingRoomScreen extends StatefulWidget {
  static String routeName = '/game_waiting_room';

  const GameWaitingRoomScreen({Key? key}) : super(key: key);

  @override
  State<GameWaitingRoomScreen> createState() => _GameWaitingRoomScreenState();
}

class _GameWaitingRoomScreenState extends State<GameWaitingRoomScreen> {
  final SocketMethods _socketMethods = SocketMethods();
  late List<dynamic> players;

  @override
  void initState() {
    super.initState();
    _socketMethods.newPlayerListener(context);
    _socketMethods.gameStartAllowListener(context);
    _socketMethods.youAreNotOwnerListener(context);
    _socketMethods.timerStartListener(context);
    _socketMethods.waitingRoomExplodeListener(context);
    _socketMethods.playerLeaveWaitingRoomFromServerListener(context);
  }

  @override
  void deactivate() {
    if(Provider.of<RoomDataProvider>(context, listen: false).mePlayer==1 && Provider.of<RoomDataProvider>(context, listen: false).isWaitingRoom!) {
      _socketMethods.ownerLeaveWaitingRoom(context);
    }
    else if(Provider.of<RoomDataProvider>(context, listen: false).isWaitingRoom! && !(Provider.of<RoomDataProvider>(context, listen: false).isExplodeByOwner!)){
      _socketMethods.playerLeaveWaitingRoom(context);
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    print('game waiting room screen build');
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    dynamic room = roomDataProvider.roomData;
    Provider.of<RoomDataProvider>(context, listen: false).setIsWaitingRoom(true);
    Provider.of<RoomDataProvider>(context, listen: false).setIsExplodeByOwner(false);
    players = [
      {'username': room['owner'], 'wins': 0, 'draws': 0, 'loses': 0},
      {'username': room['player2'], 'wins': 0, 'draws': 0, 'loses': 0},
      {'username': room['player3'], 'wins': 0, 'draws': 0, 'loses': 0},
      {'username': room['player4'], 'wins': 0, 'draws': 0, 'loses': 0},
    ];
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Room ID: ${room['id']}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ), // Room ID 텍스트
            Text(
              'Room Name: ${room['name']}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ), // Room Name 텍스트
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: players.length,
                itemBuilder: (context, index) {
                  final player = players[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            player['username'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Wins: ${player['wins']}',
                            style: const TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Provider.of<RoomDataProvider>(context, listen: false).mePlayer == 1
                ? ElevatedButton(
                    onPressed: () {
                      // 게임 시작 버튼 클릭 시 동작
                      if (roomDataProvider.mePlayer == 1) {
                        _socketMethods.gameStart(room['owner'], room['id']);
                      } else if (roomDataProvider.mePlayer == 2) {
                        _socketMethods.gameStart(room['player2'], room['id']);
                      } else if (roomDataProvider.mePlayer == 3) {
                        _socketMethods.gameStart(room['player3'], room['id']);
                      } else if (roomDataProvider.mePlayer == 4) {
                        _socketMethods.gameStart(room['player4'], room['id']);
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Start Game',
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ),
                  )
                : TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    onPressed: () {
                      // no action
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Start Game',
                        style: TextStyle(fontSize: 24.0, color: Colors.white),
                      ),
                    ),
                  ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
