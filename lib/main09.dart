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
  CustomWidget({Key? key}) : super(key: key) {
    print(listData);
  }

  // forEach写法
  List<Widget> _getListData() {
    List<Widget> widgets = [];

    listData.forEach((item) {
      widgets.add(
        Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Column(
            children: [
              SizedBox(
                width: 80,
                child: Image.network(item['imageUrl'], fit: BoxFit.cover),
              ),
              Text(item['title']),
              Text(item['subtitle']),
            ],
          ),
        ),
      );
    });
    return widgets;
  }

  // map 写法
  List<Widget> _getListMapData() {
    List<Widget> widgets = listData.map((item) {
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
    return Container(
      height: 220,
      decoration: BoxDecoration(color: Colors.yellow),
      // listView中横向布局默认子元素高度占满，设置宽度无效，需要再listView外层包裹一个容器限制高度
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(10),
        children: _getListMapData(),
      ),
    );
  }
}
