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
    return GridView.extent(
      maxCrossAxisExtent: 300, // 创建固定横轴子元素的最大宽度，根据屏幕分辨率自适应展示最大的列数，比如在iPhoneSE上设置200只能展示两列，在iPhone11上展示3列
      children: [
        Icon(Icons.tab_rounded),
        Icon(Icons.dangerous_outlined),
        Icon(Icons.u_turn_left_outlined),
        Icon(Icons.safety_check),
        Icon(Icons.ac_unit_rounded),
        Icon(Icons.kayaking_outlined),
        Icon(Icons.cabin_outlined),
        Icon(Icons.offline_pin_sharp),
        Icon(Icons.safety_divider_rounded),
        Icon(Icons.earbuds_outlined),
        Icon(Icons.cable_sharp),
        Icon(Icons.face_3_rounded),
      ],
    );
  }
}
