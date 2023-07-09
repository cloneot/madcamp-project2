import 'package:flutter/material.dart';

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
    // socket method member

    return const Scaffold(
      body: Center(
        child: Text('Game Screen'),
      ),
    );
  }
}
