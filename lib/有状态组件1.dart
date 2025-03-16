import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 状态管理类
class CounterProvider extends ChangeNotifier {
  int _listLength = 0;

  int get listLength => _listLength;

  void increment() {
    _listLength++;
    notifyListeners(); // 通知 UI 更新
  }
}

// 主页面
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: MaterialApp(
        home: HomePage(),
      ),
    ),
  );
}

// 主页
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter 共享状态示例')),
      body: CustomListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 获取 Provider 并调用 increment 方法
          Provider.of<CounterProvider>(context, listen: false).increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class CustomListWidget extends StatefulWidget {
  @override
  State<CustomListWidget> createState() => _CustomListWidgetState();
}

class _CustomListWidgetState extends State<CustomListWidget> {
  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);

    return ListView.builder(
      itemCount: counterProvider.listLength,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.network('https://img.uuuui.com/file/9d232ee426e2836ab18f1-3e7e244fc708ce40e7.png',fit: BoxFit.cover,),
          title: Text('列表 -----> ${index}'),
          subtitle: Text('subtitle -----> ${index}'),
        );
      },
    );
  }
}
