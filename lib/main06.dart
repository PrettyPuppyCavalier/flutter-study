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
          title:  Text('Flutter Demo Home Page'),
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
    return ListView(
      // scrollDirection: Axis.horizontal,
        children: <Widget>[
          Icon(keyChatIcons.aliPay),
          Text('支付宝'),
          Divider(),
          Icon(keyChatIcons.weixinPay),
          Text('微信'),
          Divider(),
          Icon(keyChatIcons.paypal),
          Text('PayPal'),
          Divider(),
          Icon(keyChatIcons.aliPay),
          Text('支付宝'),
          Divider(),
          Icon(keyChatIcons.weixinPay),
          Text('微信'),
          Divider(),
          Icon(keyChatIcons.paypal),
          Text('PayPal'),
          Divider(),
          Icon(keyChatIcons.aliPay),
          Text('支付宝'),
          Divider(),
          Icon(keyChatIcons.weixinPay),
          Text('微信'),
          Divider(),
          Icon(keyChatIcons.paypal),
          Text('PayPal'),
          Divider(),
          Icon(keyChatIcons.aliPay),
          Text('支付宝'),
          Divider(),
          Icon(keyChatIcons.weixinPay),
          Text('微信'),
          Divider(),
          Icon(keyChatIcons.paypal),
          Text('PayPal')
        ]
    );
  }
}
