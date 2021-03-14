import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sound_in_talk/src/pages/chatting_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance!.resamplingEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sound In Talk',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  ChattingPage(),
    );
  }
}