import 'package:flutter/material.dart';
import 'package:madcamp_project2/widgets/create_room_form.dart';

import '../resources/socket_methods.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create_room';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.createRoomSuccessListener(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: CreateRoomForm(),
      ),
    );
  }
}
