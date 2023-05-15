import 'package:flutter/material.dart';
import 'package:flutter_ui_factory/routes/pages.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'flutter_mobile_ui_factory',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: AppPages.routes,
      home: const MyHomePage(title: 'flutter_mobile_ui_factory'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          TextButton(onPressed: () => Get.toNamed(Routes.CHAT_INFO_SHOW), child: const Text('单条聊天消息在列表内的显示')),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
