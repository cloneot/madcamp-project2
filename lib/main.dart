import 'package:flutter/material.dart';
import 'package:madcamp_project2/screens/login_screen.dart';
import 'package:madcamp_project2/screens/game_screen.dart';
import 'package:madcamp_project2/screens/main_menu_screen.dart';
import 'package:madcamp_project2/screens/create_room_screen.dart';
import 'package:madcamp_project2/screens/join_room_screen.dart';
import 'package:madcamp_project2/screens/user_info_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        MainMenuScreen.routeName: (context) => const MainMenuScreen(),
        CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
        JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
        UsreInfoScreen.routeName: (context) => const UsreInfoScreen(),
        GameScreen.routeName: (context) => const GameScreen(),
      },
      initialRoute: MainMenuScreen.routeName,
    );
  }
}
