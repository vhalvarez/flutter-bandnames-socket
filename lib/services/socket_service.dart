import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;

  get serverStatus => _serverStatus;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    // Dart client
    IO.Socket socket = IO.io(
      'http://10.0.2.2:3000/',
      IO.OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
      .build(),
    );
    socket.onConnect((_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    socket.onDisconnect((_) {
      print('se desconecto');
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }
}
