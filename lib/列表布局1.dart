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
    // listView中垂直布局默认子元素宽度占满，设置宽度无效
    return ListView(
      // scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(10),
      children: <Widget>[
        ListTile(
          leading: Icon(keyChatIcons.aliPay),
          title: Text('支付宝'),
          subtitle: Text('这是一个支付宝'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(),
        ListTile(
          leading: Icon(keyChatIcons.weixinPay),
          title: Text('微信'),
        ),
        Divider(),
        ListTile(
          leading: Icon(keyChatIcons.paypal),
          title: Text('PayPal'),
        ),
        Divider(),
        ListTile(
          leading: Icon(keyChatIcons.aliPay),
          title: Text('支付宝'),
        ),
        Divider(),
        ListTile(
          leading: Icon(keyChatIcons.weixinPay),
          title: Text('微信'),
        ),
        Divider(),
        ListTile(
          leading: Icon(keyChatIcons.paypal),
          title: Text('PayPal'),
        ),
        Divider(),
        ListTile(
          leading: Icon(keyChatIcons.aliPay),
          title: Text('支付宝'),
        ),
        Divider(),
        ListTile(
          leading: Icon(keyChatIcons.weixinPay),
          title: Text('微信'),
        ),
        Divider(),
        ListTile(
          leading: Icon(keyChatIcons.paypal),
          title: Text('PayPal'),
        ),
        Divider(),
        ListTile(
          leading: Icon(keyChatIcons.aliPay),
          title: Text('支付宝'),
        ),
        Divider(),
        ListTile(
          leading: Icon(keyChatIcons.weixinPay),
          title: Text('微信'),
        ),
        Divider(),
        ListTile(
          leading: Icon(keyChatIcons.paypal),
          title: Text('PayPal'),
        )
      ],
    );
  }
}
