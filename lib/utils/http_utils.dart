import "package:dio/dio.dart";

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() => _instance;

  late Dio dio;

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: "http://172.10.5.113:80",
      // baseUrl: "http://localhost:80",
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
      headers: {},
      contentType: "application/json; charset=utf-8",
      responseType: ResponseType.json,
    );
    dio = Dio(options);
  }

  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool refresh = false,
    // bool noCache = !CACHE_ENABLE,
    bool list = false,
    String cacheKey = '',
    bool cacheDisk = false,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.extra ??= <String, dynamic>{};
    requestOptions.extra!.addAll({
      "refresh": refresh,
      // "noCache": noCache,
      "list": list,
      "cacheKey": cacheKey,
      "cacheDisk": cacheDisk,
    });

    var response = await dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      // cancelToken: cancelToken,
    );
    return response.data;
  }

  // Map<String, dynamic>? getAuthorizationHeader() {
  //   var headers = <String, dynamic>{};
  //   if (Get.isRegistered<UserStore>() && UserStore.to.hasToken == true) {
  //     headers['Authorization'] = 'Bearer ${UserStore.to.token}';
  //   }
  //   return headers;
  // }
}
