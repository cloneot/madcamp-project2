import 'package:flutter/material.dart';
import 'package:madcamp_project2/screens/create_room_screen.dart';
import 'package:madcamp_project2/screens/user_info_screen.dart';
import 'package:provider/provider.dart';
import '../kakao_user_view_model.dart';
import '../provider/user_data_provider.dart';
import '../utils/kakao_login.dart';
import 'join_room_screen.dart';
import 'login_screen.dart';

class MainMenuScreen extends StatefulWidget {
  static String routeName = '/main_menu';
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  bool loading = false;
  final kakaoUserViewModel = KakaoUserViewModel(KakaoLogin());

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    print('main menu joinRoom!');
    // _socketMethods.getRoomList();
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  void userInfo(BuildContext context) {
    Navigator.pushNamed(context, UsreInfoScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    print('main menu init state');
    // _socketMethods.getRoomListSuccessListener(context);
  }

  @override
  Widget build(BuildContext context) {
    print('main menu build');
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
              icon: const Icon(Icons.person_outline),
            ),
            IconButton(
              onPressed: () async {
                setState(() => loading = true);
                if (!Provider.of<UserDataProvider>(context, listen: false)
                    .isGuest) {
                  await kakaoUserViewModel.logout();
                }
                setState(() => loading = false);
                Navigator.popAndPushNamed(context, LoginScreen.routeName);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Center(child: Text('로그아웃 성공')),
                    duration: Duration(milliseconds: 1000),
                  ),
                );
              },
              icon: const Icon(Icons.logout),
            ),
            // IconButton(
            //   onPressed: () =>
            //       Navigator.pushNamed(context, GameWaitingRoomScreen.routeName),
            //   icon: const Icon(Icons.watch_later_outlined),
            // ),
            // IconButton(
            //     onPressed: () =>
            //         Navigator.pushNamed(context, GameScreen.routeName),
            //     icon: const Icon(Icons.videogame_asset_outlined)),
          ],
        ),
      ),
    );
  }
}
