import 'package:flutter/material.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import 'package:shorebird_demo/second_page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int _counter = 0;

  final shorebirdCodePush = ShorebirdCodePush();

  /// 获取当前补丁版本，如果没有安装补丁则返回null。
  int? currentPatchversion;

  /// 检查是否有补丁可供安装。
  bool isUpdateAvailable = false;

  /// 获取当前应用信息
  AppPackageInfo? package;

  @override
  void initState() {
    super.initState();
    // 检查是否有补丁可供安装。
    checkUpdate();
  }

  @override
  Widget build(BuildContext context) {
    getAppInfo(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('第一个页面'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(32),
              child: const Text(
                'shorebird说明：'
                    '\n1，必须要使用shorebird release android命令打出来的包才能有热更新功能'
                    '\n2，只有版本号(例如：1.0.0+2)相同的包才能更新补丁包'
                    '\n3，下载补丁包后，需要重启App才能生效',
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: const Text(
                '我是基于1.0.0+4版本的补丁4',
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                '当前App版本:${package?.version}',
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                '当前补丁版本:$currentPatchversion',
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                '是否存在新补丁:$isUpdateAvailable',
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                '累加数量：$_counter',
              ),
            ),
            ElevatedButton(
              onPressed: checkUpdate,
              child: const Text(
                '检查是否有更新',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: checkAndUpdate,
              child: const Text(
                '检查并且更新',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: toSecondPage,
              child: const Text(
                '第二个页面',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNum,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  /// 获取应用信息
  void getAppInfo(BuildContext context) {
    if (package == null) {
      package = AppInfo.of(context).package;
      setState(() {});
    }
  }

  /// 跳转到第二个页面
  void toSecondPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SecondPage(),
      ),
    );
  }

  /// 检查是否有补丁可供安装。
  void checkUpdate() async {
    currentPatchversion = await shorebirdCodePush.currentPatchNumber();
    isUpdateAvailable =
        await shorebirdCodePush.isNewPatchAvailableForDownload();
    setState(() {});
  }

  /// 检查并且更新
  void checkAndUpdate() async {
    currentPatchversion = await shorebirdCodePush.currentPatchNumber();
    isUpdateAvailable =
        await shorebirdCodePush.isNewPatchAvailableForDownload();
    if (isUpdateAvailable) {
      await shorebirdCodePush.downloadUpdateIfAvailable();
    }
    setState(() {});
  }

  /// 累加数量
  void addNum() {
    setState(() {
      _counter++;
    });
  }
}
