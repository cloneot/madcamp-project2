import 'package:flutter/material.dart';
import 'package:madcamp_project2/provider/room_data_provider.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  @override
  void initState() {
    super.initState();
    // socket method init
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context, listen: false);
    final dynamic room = roomDataProvider.roomData;
    // socket method member

    return Scaffold(
      body: Center(
        child: Text('Game Screen with $room'),
      ),
    );
  }
}
