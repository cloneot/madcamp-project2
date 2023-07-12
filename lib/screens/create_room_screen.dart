import 'package:flutter/material.dart';
import 'package:madcamp_project2/widgets/create_room_form.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create_room';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate(){
    _nameController.dispose();
    super.deactivate();
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
