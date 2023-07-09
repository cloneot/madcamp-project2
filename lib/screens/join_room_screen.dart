import 'package:flutter/material.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join_room';
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _gameIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  // final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    // socket method init
  }

  @override
  void dispose() {
    super.dispose();
    _gameIdController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Join Room Screen"),
      ),
    );
  }
}
