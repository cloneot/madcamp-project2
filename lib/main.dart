import 'package:flutter/material.dart';
import 'package:madcamp_project2/provider/chat_data_provider.dart';
import 'package:madcamp_project2/provider/room_data_provider.dart';
import 'package:madcamp_project2/screens/game_waiting_room.dart';
import 'package:madcamp_project2/screens/login_screen.dart';
import 'package:madcamp_project2/screens/game_screen.dart';
import 'package:madcamp_project2/screens/main_menu_screen.dart';
import 'package:madcamp_project2/screens/create_room_screen.dart';
import 'package:madcamp_project2/screens/join_room_screen.dart';
import 'package:madcamp_project2/screens/user_info_screen.dart';
import 'package:provider/provider.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

void main() {
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: 'd3d2a3123c0250e6543acdefad75de31',
    javaScriptAppKey: '194ee4633495b5756b31402116e650a2',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RoomDataProvider>(create: (context) => RoomDataProvider()),
        ChangeNotifierProvider<ChatDataProvider>(create: (context) => ChatDataProvider())
      ],
      child: MaterialApp(
        title: 'MadCampProject2',
        routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        MainMenuScreen.routeName: (context) => const MainMenuScreen(),
        CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
        JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
        UsreInfoScreen.routeName: (context) => const UsreInfoScreen(),
        GameScreen.routeName: (context) => const GameScreen(),
        GameWaitingRoomScreen.routeName: (context) =>
            const GameWaitingRoomScreen(),
      },
      initialRoute: LoginScreen.routeName,
      ),
    );
  }
}
