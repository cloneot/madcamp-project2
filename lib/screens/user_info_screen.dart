import 'package:flutter/material.dart';

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
    return Scaffold(
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
                return buildContent(snapshot.data!);
              }
            }
          },
        ),
      ),
    );
  }

  Widget buildContent(Users user) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          const SizedBox(height: 100),
          TextField(controller: usernameController),
          TextField(controller: descriptionController),
          Text('${user.wins}승 / ${user.draws}무 / ${user.losses}패'),
          ElevatedButton(
              onPressed: () {
                print(
                    '${usernameController.text}, ${descriptionController.text}');
              },
              child: const Text('저장')),
        ],
      ),
    );
  }
}
