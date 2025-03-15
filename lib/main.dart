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
    return GridView.count(crossAxisCount: 3, children: [
      Icon(Icons.tab_rounded),
      Icon(Icons.dangerous_outlined),
      Icon(Icons.u_turn_left_outlined),
      Icon(Icons.safety_check),
      Icon(Icons.ac_unit_rounded),
      Icon(Icons.kayaking_outlined),
      Icon(Icons.cabin_outlined),
      Icon(Icons.offline_pin_sharp ),
      Icon(Icons.safety_divider_rounded),
      Icon(Icons.earbuds_outlined),
      Icon(Icons.cable_sharp),
      Icon(Icons.face_3_rounded),
    ]);
  }
}
