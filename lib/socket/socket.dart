import 'package:socket_io_client/socket_io_client.dart' as IO;

IO.Socket socket = IO.io('http://35.231.17.177/', <String, dynamic>{
  'transports': ['websocket'],
});
