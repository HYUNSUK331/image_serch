import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/constants.dart';
import 'package:untitled/tabs.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized(); //
  Constants.prefs = await SharedPreferences.getInstance();


  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(   // 코드를 줄일 수 있고, 모든 페이지의 최상단으로 사용 하겠다는 의미이다.
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Tabs(),     // home으로 사용하겠다는 의미
    );
  }
}