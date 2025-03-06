import 'package:flutter/material.dart';
import './keyChatIcons.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      // 此配置已失效
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo Home Page'),
          backgroundColor: Colors.red,
        ),
        body: const CustomWidget(),
      ),
    ),
  );
}

class CustomWidget extends StatelessWidget {
  const CustomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 内置图标 图标库地址 https://fonts.google.com/icons
        Icon(Icons.add, color: Colors.red, size: 50),
        Icon(Icons.home, color: Colors.blue, size: 20),
        Icon(Icons.account_circle, color: Colors.yellow, size: 20),
        SizedBox(height: 20),
        Text('Hello World'),
        SizedBox(height: 20),

        // 自定义图标 只支持设置单一颜色 多颜色图标使用svg保证没有锯齿
        Icon(keyChatIcons.aliPay, size: 30, color: Color(0xFF5A9EF7)),
        Icon(keyChatIcons.weixinPay, size: 30, color: Color(0xFF28C445)),
        Icon(keyChatIcons.paypal, size: 30, color: Color(0xFF28C445)),
      ],
    );
  }
}
