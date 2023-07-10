import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  //late final dynamic room;

  @override
  void initState() {
    super.initState();
    //room = ModalRoute.of(context)?.settings.arguments;
    // socket method init
  }

  @override
  Widget build(BuildContext context) {
    // socket method member

    return const Scaffold(
      body: Center(
        child: Text('Game Screen'),
      ),
    );
  }
}
