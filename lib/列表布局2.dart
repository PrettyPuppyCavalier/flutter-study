import 'package:flutter/material.dart';
import './keyChatIcons.dart';

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
        body: const CustomWidget(),
      ),
    ),
  );
}

class CustomWidget extends StatelessWidget {
  const CustomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      // listView中横向布局默认子元素高度占满，设置宽度无效，需要再listView外层包裹一个容器限制高度

      child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            Container(
                width: 100,
                decoration: BoxDecoration(color: Colors.red),
                child: Column(
                  children: <Widget>[
                    // 若是图片超出高度导致文字无法显示，需要设置图片高度，图片本身不支持宽高属性，所以需要包裹一个SizedBox，或者container
                    // 项目场景中应该是flex布局，后面再看
                    SizedBox(
                      height: 60,
                      width: 50,
                      child: Image.asset(
                          'assets/images/img.jpg', fit: BoxFit.cover),
                    ),
                    Text('支付宝'),
                  ],
                )
            ),
            Container(
                width: 100, decoration: BoxDecoration(color: Colors.blue)),
            Container(
                width: 100, decoration: BoxDecoration(color: Colors.yellow)),
            Container(
                width: 100, decoration: BoxDecoration(color: Colors.pink)),
            Container(
                width: 100, decoration: BoxDecoration(color: Colors.green)),
            Container(
                width: 100, decoration: BoxDecoration(color: Colors.black)),
          ]
      ),
    ); // ✅ 这里结尾修正为 `),`
  }
}
