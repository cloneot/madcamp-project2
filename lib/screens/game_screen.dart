import 'package:flutter/material.dart';
import 'package:madcamp_project2/provider/room_data_provider.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  @override
  void initState() {
    super.initState();
    // socket method init
}
  final String roomId = '12345';
  final String roomName = 'Game Room';
  final List<Player> players = [
    Player(username: 'Player 1', winRoundCount: 2, currentRoundScore: 100),
    Player(username: 'Player 2', winRoundCount: 1, currentRoundScore: 50),
    Player(username: 'Player 3', winRoundCount: 0, currentRoundScore: 0),
    Player(username: 'Player 4', winRoundCount: 3, currentRoundScore: 150),
  ];
  final List<ChatMessage> chatMessages = [
    ChatMessage(
      message: 'Hello1',
      messageScore: 20,
      sendingPlayer: 'Player 1',
    ),
    ChatMessage(
      message: 'Good job!',
      messageScore: 10,
      sendingPlayer: 'Player 3',
    ),
    ChatMessage(
      message: 'Thanks!',
      messageScore: 5,
      sendingPlayer: 'Player 2',
    ),
    ChatMessage(
      message: 'Hello',
      messageScore: 20,
      sendingPlayer: 'Player 1',
    ),
    ChatMessage(
      message: 'Hello',
      messageScore: 20,
      sendingPlayer: 'Player 1',
    ),
    ChatMessage(
      message: 'Good job!',
      messageScore: 10,
      sendingPlayer: 'Player 3',
    ),
    ChatMessage(
      message: 'Thanks!',
      messageScore: 5,
      sendingPlayer: 'Player 2',
    ),
    ChatMessage(
      message: 'Hello',
      messageScore: 20,
      sendingPlayer: 'Player 1',
    ),
    ChatMessage(
      message: 'Hello',
      messageScore: 20,
      sendingPlayer: 'Player 1',
    ),
    ChatMessage(
      message: 'Good job!',
      messageScore: 10,
      sendingPlayer: 'Player 3',
    ),
    ChatMessage(
      message: 'Thanks!',
      messageScore: 5,
      sendingPlayer: 'Player 2',
    ),
    ChatMessage(
      message: 'Hello',
      messageScore: 20,
      sendingPlayer: 'Player 1',
    ),
  ];
  final int timerValue = 120;

  final TextEditingController _chatController = TextEditingController();
  final ScrollController _chatScrollController = ScrollController();
  final FocusNode _chatFocusNode = FocusNode();

  @override
  void dispose() {
    _chatController.dispose();
    _chatScrollController.dispose();
    _chatFocusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    String message = _chatController.text.trim();
    if (message.isNotEmpty) {
      // Process the sent message, e.g., send it to the server
      _chatController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context, listen: false);
    final dynamic room = roomDataProvider.roomData;
    // socket method member
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roomName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Room ID: $roomId',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            Text(
              'Timer: $timerValue seconds',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: players.map((player) {
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              player.username,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Win: ${player.winRoundCount}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              'Score: ${player.currentRoundScore}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Text(
                    //   'Chat:',
                    //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    // ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.separated(
                        controller: _chatScrollController,
                        reverse: true,
                        itemCount: chatMessages.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final reversedIndex = chatMessages.length - 1 - index;
                          final message = chatMessages[reversedIndex];
                          return ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            title: Text(
                              message.message,
                              style: const TextStyle(fontSize: 14),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Score: ${message.messageScore}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                Text(
                                  message.sendingPlayer,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _chatController,
                            focusNode: _chatFocusNode,
                            decoration: const InputDecoration(
                              hintText: 'Type a message...',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: _sendMessage,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*

 */
class Player {
  final String username;
  final int winRoundCount;
  final int currentRoundScore;

  Player({
    required this.username,
    required this.winRoundCount,
    required this.currentRoundScore,
  });
}

class ChatMessage {
  final String message;
  final int messageScore;
  final String sendingPlayer;

  ChatMessage({
    required this.message,
    required this.messageScore,
    required this.sendingPlayer,
  });
}
