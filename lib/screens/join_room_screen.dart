import 'package:flutter/material.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join_room';
  const JoinRoomScreen({Key? key}) : super(key: key);

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _gameIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  List<RoomData> roomList = [
    RoomData(1234, "Room 1", "Player 1"),
    RoomData(4321, "test!", "junseo"),
    RoomData(414231, "Hello World!", "user1234"),
    RoomData(1234, "Room 1", "Player 1"),
    RoomData(4321, "test!", "junseo"),
    RoomData(414231, "Hello World!", "user1234"),
    RoomData(1234, "Room 1", "Player 1"),
    RoomData(4321, "test!", "junseo"),
    RoomData(414231, "Hello World!", "user1234"),
    RoomData(1234, "Room 1", "Player 1"),
    RoomData(4321, "test!", "junseo"),
    RoomData(414231, "Hello World!", "user1234"),
    RoomData(1234, "Room 1", "Player 1"),
    RoomData(4321, "test!", "junseo"),
    RoomData(414231, "Hello World!", "user1234"),
    RoomData(1234, "Room 1", "Player 1"),
    RoomData(4321, "test!", "junseo"),
    RoomData(414231, "Hello World!", "user1234"),
  ];

  @override
  void dispose() {
    super.dispose();
    _gameIdController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView.separated(
            itemCount: roomList.length,
            itemBuilder: (context, index) {
              return Container(
                child: ListTile(
                  title: Text(roomList[index].roomName),
                  subtitle: Text(roomList[index].roomOwner),
                  onTap: () {
                    _showConfirmationDialog(context, roomList[index]);
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(height: 10, color: Colors.blue);
            },
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, RoomData room) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('방 정보'),
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('room id: ${room.roomId}'),
                Text('room name: ${room.roomName}'),
                Text('room owner: ${room.roomOwner}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('들어가기'),
              onPressed: () {
                // TODO: 방에 들어가는 로직을 여기에 구현합니다.
                Navigator.pop(context); // 다이얼로그 닫기
              },
            ),
            TextButton(
              child: const Text('취소'),
              onPressed: () {
                Navigator.pop(context); // 다이얼로그 닫기
              },
            ),
          ],
        );
      },
    );
  }
}

class RoomData {
  int roomId;
  String roomName;
  String roomOwner;
  RoomData(this.roomId, this.roomName, this.roomOwner);
}
