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
      // 全屏背景
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black12,
      child: Row(
        // 横轴 --------------------------------
        // 水平居中
        // mainAxisAlignment: MainAxisAlignment.center,
        // 末尾对齐
        // mainAxisAlignment: MainAxisAlignment.end,
        // 两端对齐，多余的空间平均分配
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // 均分间距相等
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // 中间的间距是两边间距的2倍
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        // 竖轴 --------------------------------
        // 竖轴是基于外层容器的高度，所以需要加一个外层容器
        // 垂直居中
        crossAxisAlignment: CrossAxisAlignment.center,
        // 底部对齐
        // crossAxisAlignment: CrossAxisAlignment.end,
        // 两端对齐，多余的空间平均分配
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        // 均分间距相等
        // crossAxisAlignment: CrossAxisAlignment.center,
        // 中间的间距是两边间距的2倍
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IconContainer(Icons.android, color: Colors.red, size: 40),
          IconContainer(Icons.apple, color: Colors.green, size: 40),
          IconContainer(Icons.window, color: Colors.blue, size: 40),
        ],
      ),
    );
  }
}

class IconContainer extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;

  IconContainer(this.icon, {Key? key, required this.color, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 80,
      height: 80,
      decoration: BoxDecoration(color: color),
      child: Center(child: Icon(icon, color: Colors.white, size: size)),
    );
  }
}