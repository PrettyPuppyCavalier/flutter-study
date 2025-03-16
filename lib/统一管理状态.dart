import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 状态管理类
class CounterProvider extends ChangeNotifier {
  int _count = 0;
  bool _isActive = false;

  int get count => _count;
  bool get isActive => _isActive;

  void increment() {
    _count++;
    notifyListeners(); // 通知 UI 更新
  }

  void toggleActive() {
    _isActive = !_isActive;
    notifyListeners();
  }
}

// 计数组件
class CounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);

    return Column(
      children: [
        Text('计数：${counterProvider.count}'),
        ElevatedButton(
          onPressed: counterProvider.increment,
          child: Text('增加'),
        ),
      ],
    );
  }
}

// 开关组件
class SwitchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);

    return Column(
      children: [
        Switch(
          value: counterProvider.isActive,
          onChanged: (value) => counterProvider.toggleActive(),
        ),
        Text(counterProvider.isActive ? '激活状态' : '未激活'),
        Text('计数：${counterProvider.count}'),
      ],
    );
  }
}

// 主页面
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('Flutter 共享状态示例')),
          body: Column(
            children: [
              CounterWidget(),
              SwitchWidget(),
            ],
          ),
        ),
      ),
    ),
  );
}