import 'package:flutter/material.dart';

/// 第二个页面
class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('第二个页面'),
      ),
      body: const Center(
        child: Text(
          '这是第二个页面',
        ),
      ),
    );
  }
}
