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

  List<Widget> _getListData() {
    List<Widget> widgets = [];
    for (var i = 0; i < 20; i++) {
      widgets.add(
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.deepPurpleAccent),
          child: Text(
            'item - $i',
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      /*gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // 水平间距
        crossAxisSpacing: 10,
        // 垂直间距
        mainAxisSpacing: 10,
        // 子元素宽高比 1 是正方形
        childAspectRatio: 1.5,
        crossAxisCount: 3,
      ),*/

      // 必须传入maxCrossAxisExtent，效果与
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        // 水平间距
        crossAxisSpacing: 10,
        // 垂直间距
        mainAxisSpacing: 10,
        // 子元素宽高比 1 是正方形
        childAspectRatio: 1.5,
        // 创建固定横轴子元素的最大宽度，根据屏幕分辨率自适应展示最大的列数，比如在iPhoneSE上设置200只能展示两列，在iPhone11上展示3列
        maxCrossAxisExtent: 300,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.deepPurpleAccent),
          child: Text(
            'item - $index',
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
        );
      },
    );
  }
}
