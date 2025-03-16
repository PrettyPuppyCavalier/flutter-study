import 'package:flutter/material.dart';
import './components/tabbar/tabs.dart';
import './res/listData.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      // 此配置已失效
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CustomWidget(),
    ),
  );
}

class CustomWidget extends StatelessWidget {
  CustomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Home Page'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.yellow),
        // listView中横向布局默认子元素高度占满，设置宽度无效，需要再listView外层包裹一个容器限制高度
        child: ListView.builder(
          itemCount: listData.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image.network(listData[index]['imageUrl']),
              title: Text(listData[index]['title']),
              subtitle: Text(listData[index]['subtitle']),
            );
          },
        ),
      ),
      // 没有实现页面切换，因为老师教的太菜，后面学路由方式
      bottomNavigationBar: BottomNavigationBarItems()
    );
  }
}
