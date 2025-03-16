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
    return ListView(
      children: [
        Wrap(
          spacing: 10, // 主轴方向上的间距
          runSpacing: 10, // 交叉轴方向上的间距
          children: [
            ElevatedButton(
              onPressed: () {
                print('ElevatedButton button');
              },
              child: Text('常规按钮'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.deepPurple),
                foregroundColor: WidgetStateProperty.all(Colors.white),
              ),
              onPressed: () {
                print('ElevatedButton button');
              },
              child: Text('修改颜色'),
            ),
            SizedBox(
              width: 200,
              height: 70,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.deepPurple),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                ),
                onPressed: () {
                  print('ElevatedButton button');
                },
                child: Text('修改宽高'),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                print('ElevatedButton button');
              },
              label: Text('常规按钮可加icon'),
              icon: Icon(Icons.linked_camera),
            ),
            OutlinedButton(
              onPressed: () {
                print('OutlinedButton button');
              },
              child: Text('OutlinedButton'),
            ),
            OutlinedButton.icon(
              onPressed: () {
                print('OutlinedButton button');
              },
              label: Text('OutlinedButton'),
              icon: Icon(Icons.linked_camera),
            ),
            TextButton(
              onPressed: () {
                print('TextButton button');
              },
              child: Text('TextButton'),
            ),
            TextButton.icon(
              onPressed: () {
                print('TextButton button');
              },
              icon: Icon(Icons.linked_camera),
              label: Text('TextButton'),
            ),
            IconButton(
              onPressed: () {
                print('IconButton button');
              },
              icon: Icon(Icons.linked_camera),
            ),
          ],
        ),
      ],
    );
  }
}
