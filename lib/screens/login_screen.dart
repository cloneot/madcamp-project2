import 'dart:convert';

import 'package:flutter/material.dart';

import '../kakao_user_view_model.dart';
import '../utils/http_utils.dart';
import '../utils/kakao_login.dart';
import 'main_menu_screen.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final kakaoUserViewModel = KakaoUserViewModel(KakaoLogin());

  @override
  Widget build(BuildContext context) {
    print('rebuild!');
    if (kakaoUserViewModel.isLogined) {
      try {
        final int id = kakaoUserViewModel.user!.id;
        final String nickname =
            kakaoUserViewModel.user!.kakaoAccount!.profile!.nickname!;

        const JsonCodec json = JsonCodec();
        final dynamic data = json.encode({'username': nickname});

        // print(queryParameter);
        HttpUtil().put('/users/$id', data: data);
        Navigator.pushNamed(context, MainMenuScreen.routeName);
      } catch (e) {
        // print('error: $e');
        print('isLogined: true, but cannot get user.id');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(kakaoUserViewModel.user?.id.toString() ?? '-1'),
            Text(kakaoUserViewModel.user?.toJson().toString() ?? '-1'),
            Text(kakaoUserViewModel.user?.kakaoAccount?.profile?.nickname ??
                'nickname'),
            // Image.network(
            //     kakaoUserViewModel.user?.kakaoAccount?.profile?.thumbnailImageUrl ?? ''),
            Text(
              '${kakaoUserViewModel.isLogined}',
              style: const TextStyle(fontSize: 30),
            ),
            TextButton(
              onPressed: () async {
                await kakaoUserViewModel.login();
                if (kakaoUserViewModel.isLogined) {
                  setState(() {});
                  print(kakaoUserViewModel.user?.toJson());
                  // Navigator.pushNamed(context, MainMenuScreen.routeName);
                }
              },
              child: const Text('카카오 로그인'),
            ),
            TextButton(
              onPressed: () async {
                await kakaoUserViewModel.logout();
                print('log out ! ');
                setState(() {});
              },
              child: const Text('로그아웃'),
            ),
            IconButton(
              onPressed: () {
                // Navigator.pushNamed(context, MainMenuScreen.routeName);
              },
              icon: const Icon(Icons.arrow_circle_right_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
