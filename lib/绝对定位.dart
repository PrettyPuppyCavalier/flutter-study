import 'package:flutter/material.dart';
import './res/listData.dart';

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

  // map 写法
  List<Widget> _getListMapData() {
    List<Widget> widgets =
        listData.map((item) {
          return Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: 120,
                  child: Image.network(item['imageUrl'], fit: BoxFit.cover),
                ),
                Text(item['title']),
                Text(item['subtitle']),
              ],
            ),
          );
        }).toList();

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.only(top: 40),
          scrollDirection: Axis.vertical,
          children: _getListMapData(),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          height: 40,
          left: 0,
          top: 0,
          child: Container(
            alignment: Alignment.center,
            color: Colors.black,
            child: Text('模拟导航', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
