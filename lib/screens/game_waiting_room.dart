import 'package:flutter/material.dart';

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
  _GameWaitingRoomScreenState createState() => _GameWaitingRoomScreenState();
}

class _GameWaitingRoomScreenState extends State<GameWaitingRoomScreen> {
  int roomId = 12345; // Room ID 변수
  String roomName = 'Game Room'; // Room Name 변수
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

  @override
  void initState() {
    super.initState();
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
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Room ID: $roomId',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ), // Room ID 텍스트
            Text(
              'Room Name: $roomName',
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
                            player.username,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Wins: ${player.wins}',
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            'Draws: ${player.draws}',
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            'Loses: ${player.loses}',
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
