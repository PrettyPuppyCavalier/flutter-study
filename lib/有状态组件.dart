import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo Home Page'),
          backgroundColor: Colors.red,
        ),
        body: CounterWidget(),
      ),
    ),
  );
}

// 创建一个计数器组件
class CounterWidget extends StatefulWidget {
  const CounterWidget({Key? key}) : super(key: key);

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

/**
 * 为什么状态要放在 State 里？
 * 1，StatefulWidget 只是一个壳，它唯一的作用是 创建 State，并不会存储任何状态
 * 2，真正的状态逻辑是由 State<T> 维护的，Flutter 通过 setState() 触发状态更新，并重新构建 build() 方法。
 * 3，setState() 告诉 Flutter：数据变了，UI 需要重新构建。Flutter 重新调用 build() 方法，并更新界面。
 * 4，所有 有状态的组件 都需要 StatefulWidget + State ！！！！！
 * 5，StatefulWidget 只负责创建 State，但它本身是 不可变的，无法存储状态。
 * 6，状态必须放在 State 里，通过 setState() 更新。
 */
class _CounterWidgetState extends State<CounterWidget> {
  int _num = 0; // 将 `num` 移到 State 里

  void _increment() {
    setState(() {
      _num++; // 更新状态并重新渲染 UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // 让组件居中
      children: [
        Text(
          '$_num',
          style: TextStyle(fontSize: 30),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _increment, // 按钮点击时调用 `_increment`
          child: Text('点击', style: TextStyle(fontSize: 20)),
        ),
      ],
    );
  }
}