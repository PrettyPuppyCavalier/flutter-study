import 'package:flutter/material.dart';
import './routers/routers.dart';

void main() {
  runApp(
    MaterialApp(
      // 关闭debug模式
      debugShowCheckedModeBanner: false,
      home: CustomWidget(),
      initialRoute: '/home',
      onGenerateRoute: onGenerateRoute,
    ),
  );
}

class CustomWidget extends StatelessWidget {
  CustomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/config',
                arguments: {'id': 123123123},
              );
            },
            child: Text('pushName跳转config'),
          ),
        ],
      ),
    );
  }
}
