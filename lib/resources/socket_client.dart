import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  IO.Socket? socket;
  static SocketClient? _instance;

  SocketClient._internal() {
    // socket = IO.io('http://172.10.5.98', <String, dynamic>{
    //   'transports': ['websocket'],
    //   'autoConnect': false,
    // });
    socket = IO.io('http://172.10.5.113', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
