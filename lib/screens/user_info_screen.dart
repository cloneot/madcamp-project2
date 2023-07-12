import 'package:flutter/material.dart';
import 'package:madcamp_project2/provider/user_data_provider.dart';
import 'package:provider/provider.dart';

import '../kakao_user_view_model.dart';
import '../models/users.dart';
import '../utils/http_utils.dart';
import '../utils/kakao_login.dart';

class UsreInfoScreen extends StatefulWidget {
  static String routeName = '/user_info';
  const UsreInfoScreen({super.key});

  @override
  State<UsreInfoScreen> createState() => _UsreInfoScreenState();
}

class _UsreInfoScreenState extends State<UsreInfoScreen> {
  final kakaoUserViewModel = KakaoUserViewModel(KakaoLogin());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('user info init state');
  }

  Future<Users> fetchData() async {
    int userid = (await kakaoUserViewModel.getUser()).id;
    Users user = Users.fromMap((await HttpUtil().get('/users/$userid')));
    usernameController.text = user.username;
    descriptionController.text = user.description;
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<UserDataProvider>(context, listen: false).userid == -1
        ? const Scaffold(
            body: Center(
              child: Text(
                '게스트는 유저 정보를 볼 수 없습니다.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          )
        : Scaffold(
            body: Center(
              child: FutureBuilder<Users>(
                future: fetchData(),
                builder: (BuildContext context, AsyncSnapshot<Users> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // 로딩 중인 경우
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasError) {
                      // 에러가 발생한 경우
                      return const Center(
                        child: Text('사용자 정보를 확인할 수 없습니다. '),
                      );
                    } else {
                      // 작업이 완료된 경우 데이터를 기반으로 화면을 구성하는 위젯 반환
                      return buildContent();
                    }
                  }
                },
              ),
            ),
          );
  }

  Widget buildContent() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          const SizedBox(height: 100),
          TextField(controller: usernameController, readOnly: true),
          TextField(controller: descriptionController),
          Text(
              '${Provider.of<UserDataProvider>(context, listen: true).wins}승 / ${Provider.of<UserDataProvider>(context, listen: true).totalGames}판'),
          ElevatedButton(
              onPressed: () {
                // print(
                //     '${usernameController.text}, ${descriptionController.text}');
                Provider.of<UserDataProvider>(context, listen: false)
                    .updateDescription(descriptionController.text);
              },
              child: const Text('저장')),
          TextButton(
            onPressed: () {
              Provider.of<UserDataProvider>(context, listen: false)
                  .gameEnd(true);
            },
            child: const Text('승리 테스트'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<UserDataProvider>(context, listen: false)
                  .gameEnd(false);
            },
            child: const Text('패배 테스트'),
          ),
        ],
      ),
    );
  }
}
