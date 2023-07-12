import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:madcamp_project2/utils/http_utils.dart';
import 'package:provider/provider.dart';

import '../kakao_user_view_model.dart';
import '../provider/user_data_provider.dart';
import '../utils/kakao_login.dart';
import 'main_menu_screen.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final kakaoUserViewModel = KakaoUserViewModel(KakaoLogin());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
      ),
      body: Center(
        child: loading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      await kakaoUserViewModel.login();
                      if (kakaoUserViewModel.isLogined) {
                        try {
                          final int id = kakaoUserViewModel.user!.id;
                          final String nickname = kakaoUserViewModel
                              .user!.kakaoAccount!.profile!.nickname!;
                          print('id: $id');
                          print('nickname: $nickname');

                          const JsonCodec json = JsonCodec();
                          final dynamic data =
                              json.encode({'username': nickname});

                          await HttpUtil().put('/users/$id', data: data);
                          if (kakaoUserViewModel.isLogined) {
                            if (!mounted) return;

                            Provider.of<UserDataProvider>(context,
                                    listen: false)
                                .fetchData();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Center(
                                  child: Text('카카오 로그인 성공'),
                                ),
                                duration: Duration(milliseconds: 1000),
                              ),
                            );
                            Navigator.pushNamed(
                                context, MainMenuScreen.routeName);
                          }
                        } catch (e) {
                          print('error: $e');
                        }
                      }
                      setState(() {
                        loading = false;
                      });
                    },
                    child: const Text('로그인'),
                  ),
                  // TextButton(
                  //   onPressed: () async {
                  //     setState(() {
                  //       loading = true;
                  //     });
                  //     await kakaoUserViewModel.logout();
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(
                  //         content: Center(child: Text('로그아웃 성공.')),
                  //         duration: Duration(milliseconds: 1000),
                  //       ),
                  //     );
                  //     setState(() {
                  //       loading = false;
                  //     });
                  //   },
                  //   child: const Text('로그아웃'),
                  // ),
                  TextButton(
                    onPressed: () {
                      Provider.of<UserDataProvider>(context, listen: false)
                          .setGuest();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Center(
                            child: Text('게스트 로그인 성공'),
                          ),
                          duration: Duration(milliseconds: 1000),
                        ),
                      );
                      Navigator.pushNamed(context, MainMenuScreen.routeName);
                    },
                    child: const Text('게스트 로그인'),
                  ),
                ],
              ),
      ),
    );
  }
}
