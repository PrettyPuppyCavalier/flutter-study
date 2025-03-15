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
    // 层叠元素，和css定位差不多，Stack代表内部元素为定位元素，使用Positioned包裹进行位置设置，Positioned基于Stack的父级元素宽高进行定位
    return Container(
      width: 500,
      height: 500,
      color: Colors.black12,
      child: Stack(
        children: [
          Positioned(
            left: 100,
            top: 50,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
          ),
          Positioned(
            left: 200,
            top: 150,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.yellow,
            ),
          ),
        ],
      ),
    );
  }
}

