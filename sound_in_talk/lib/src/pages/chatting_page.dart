import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChattingPage extends StatefulWidget {
  @override
  _ChattingPageState createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  final WebSocketChannel channel = IOWebSocketChannel.connect(Uri.parse('ws://localhost:5556'));
  TextEditingController _controller = TextEditingController();

  List<String> messages = [];

  @override
  void initState() {
    channel.stream.listen((event) {
      setState(() {
        messages.insert(0, event);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Single Room'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: Container(
                margin: EdgeInsets.all(16),
                child: ListView.builder(
                  reverse: true,
                  itemBuilder: (context, index) => makeBubbleTextView(messages[index]),
                  itemCount: messages.length,
                ),
              ),
            ),
            Divider(height: 1),
            Container(
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration.collapsed(hintText: "Send a message"),
                      onSubmitted: (_) => sendMessage(),
                    ),
                  ),
                  IconButton(
                    onPressed: sendMessage,
                    icon: Icon(Icons.send),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage() {
    if (_controller.text.isEmpty) return;

    setState(() {
      channel.sink.add(_controller.text);
      _controller.clear();
    });
  }

  Widget makeBubbleTextView(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}