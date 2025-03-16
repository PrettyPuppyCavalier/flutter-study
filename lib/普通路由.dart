import 'package:flutter/material.dart';
import './pages/details.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DetailsPage(id: 123)),
              );
            },
            child: Text('of跳转'),
          ),
        ],
      ),
    );
  }
}
