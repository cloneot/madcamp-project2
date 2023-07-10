import 'package:flutter/material.dart';
import 'package:madcamp_project2/screens/create_room_screen.dart';
import 'package:madcamp_project2/screens/join_room_screen.dart';
import 'package:madcamp_project2/screens/user_info_screen.dart';

import 'login_screen.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = '/main_menu';
  const MainMenuScreen({super.key});

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  void userInfo(BuildContext context) {
    Navigator.pushNamed(context, UsreInfoScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () => createRoom(context),
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: () => joinRoom(context),
              icon: const Icon(Icons.search_rounded),
            ),
            IconButton(
              onPressed: () => userInfo(context),
              icon: const Icon(Icons.person),
            ),
            IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, LoginScreen.routeName),
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
