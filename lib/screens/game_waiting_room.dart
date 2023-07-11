import 'package:flutter/material.dart';
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
  /*
  final List<Player> players = [
    Player(
      userId: 1,
      username: "Player 1",
      totalGames: 10,
      wins: 5,
      loses: 3,
      draws: 2,
    ),
    Player(
      userId: 2,
      username: "Player 2",
      totalGames: 8,
      wins: 4,
      loses: 2,
      draws: 2,
    ),
    Player(
      userId: 3,
      username: "Player 3",
      totalGames: 6,
      wins: 3,
      loses: 2,
      draws: 1,
    ),
    Player(
      userId: 4,
      username: "Player 4",
      totalGames: 12,
      wins: 7,
      loses: 4,
      draws: 1,
    ),
  ];
   */

  @override
  void initState() {
    super.initState();
    _socketMethods.newPlayerListener(context);
    _socketMethods.gameStartAllowListener(context);
    _socketMethods.youAreNotOwnerListener(context);

    // channel.stream.listen((message) {
    //   // WebSocket 메시지 수신
    //   // 메시지를 파싱하여 플레이어 정보 업데이트
    //   setState(() {
    //     players = parsePlayerInfo(message);
    //   });
    // });
  }

  @override
  void dispose() {
    // channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    dynamic room = roomDataProvider.roomData;
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
                          const SizedBox(height: 2.0),
                          Text(
                            'Draws: ${player['draws']}',
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            'Loses: ${player['loses']}',
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
            ElevatedButton(
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
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
