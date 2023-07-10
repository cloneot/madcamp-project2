import "package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart";
import "package:madcamp_project2/utils/kakao_login.dart";

class KakaoUserViewModel {
  final KakaoLogin _kakaoLogin;
  bool isLogined = false;
  User? user;

  KakaoUserViewModel(this._kakaoLogin);

  Future login() async {
    isLogined = await _kakaoLogin.login();
    if (isLogined) {
      user = await UserApi.instance.me();
    }
  }

  Future logout() async {
    isLogined = false;
    user = null;
    await _kakaoLogin.logout();
  }
}
