import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:sound_in_talk/src/pages/chatting_page.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:sound_in_talk/src/room_data.dart';

// ignore: must_be_immutable
class JoinRoomPage extends StatelessWidget {
  TextEditingController _controller = TextEditingController();
  IO.Socket socket = IO.io(
    'https://hseoy-simple-chat-server.herokuapp.com/',
    OptionBuilder().setTransports(['websocket']).build(),
  );

  @override
  Widget build(BuildContext context) {
    socket.onConnect((_) => print('open'));

    return Scaffold(
      appBar: AppBar(
        title: Text('input your information'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            onSubmitted: (_) => inputInfo(),
          ),
          TextButton(
            onPressed: inputInfo,
            child: Text('enter'),
          ),
        ],
      ),
    );
  }

  inputInfo() {
    var information = _controller.text;
    if (information.isEmpty && information.contains(',')) return;

    var data = information.split(',');
    socket.emit('login', RoomData(data[0], data[1]).toJson());
    Get.to(ChattingPage(socket, data[1]));
  }
}
