import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import '../models/users.dart';
import '../utils/http_utils.dart';
import '../utils/kakao_login.dart';

class UserDataProvider extends ChangeNotifier {
  int? _userid;
  String? _username;
  int? _totalGames;
  int? _wins;
  String? _description;

  int? get userid => _userid;
  String? get username => _username;
  int? get wins => _wins;
  int? get totalGames => _totalGames;
  bool get isGuest => _userid == -1;
  String get description => _description ?? 'default description';

  void fetchData() async {
    if ((await KakaoLogin().login())) {
      User kakaoUser = await UserApi.instance.me();
      _userid = kakaoUser.id;
      _username = kakaoUser.kakaoAccount!.profile!.nickname;

      print('fetch data _userid: $userid, _username: $username');

      Users user = Users.fromMap((await HttpUtil().get('/users/$_userid')));
      _wins = user.wins;
      _totalGames = user.totalGames;
    }
  }

  void setGuest() {
    int rnd = 1000 + Random().nextInt(9000);
    _userid = -1;
    _username = 'guest$rnd';
    _wins = 0;
    _totalGames = 0;
  }

  void gameEnd(bool isWin) {
    if (isWin) {
      _wins = _wins! + 1;
    }
    _totalGames = _totalGames! + 1;

    if (_userid != -1) {
      const JsonCodec json = JsonCodec();
      final dynamic data = json.encode({'is_win': isWin});
      HttpUtil().put('/users/$_userid/game_end', data: data);
    }
    notifyListeners();
  }

  void updateDescription(String description) {
    if (_userid != -1) {
      const JsonCodec json = JsonCodec();
      final dynamic data = json.encode({'description': description});
      HttpUtil().put('/users/$_userid/description', data: data);
    }
    notifyListeners();
  }
}
