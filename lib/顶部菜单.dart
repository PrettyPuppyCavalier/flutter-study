import 'package:flutter/material.dart';
import './components/tabbar/tabs.dart';
import './res/listData.dart';

void main() {
  runApp(
    MaterialApp(
      // 关闭debug模式
      debugShowCheckedModeBanner: false,
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
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () => print('点击了头像'),
        ),
        title: Text('Flutter Demo Home Page'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => print('点击了设置'),
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => print('点击菜单'),
          ),
        ],
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
      drawer: Drawer(child: Text('左侧菜单')),
      endDrawer: Drawer(child: Text('右侧菜单')),
      bottomNavigationBar: BottomNavigationBarItems(),
    );
  }
}
