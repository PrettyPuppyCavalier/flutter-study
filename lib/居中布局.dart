import 'package:flutter/material.dart';

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
        body: CustomWidget(),
      ),
    ),
  );
}

class CustomWidget extends StatelessWidget {
  CustomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      // 水平居中方式1
      // alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.yellow),
      // 水平居中方式2，使用Center包裹
      child: Center(
        child: Text(
          'Hello World',
          style: TextStyle(color: Colors.red, fontSize: 28),
        ),
      ),
    );
  }
}