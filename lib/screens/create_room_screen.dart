import 'package:flutter/material.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create_room';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  // final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    // socket init
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Create Room Screen"),
      ),
    );
  }
}
