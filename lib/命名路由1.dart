import 'package:flutter/material.dart';
import './pages/details.dart';
import './pages/search.dart';

void main() {
  runApp(
    MaterialApp(
      // 关闭debug模式
      debugShowCheckedModeBanner: false,
      home: CustomWidget(),
      routes: {
        '/details': (context) => DetailsPage(id: 123),
        '/search': (context) => SearchPage(id: 123),

      },
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
              Navigator.pushNamed(context, '/details', arguments: {'id': 11111});
            },
            child: Text('pushName跳转Details'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/search', arguments: {'id': 44444});
            },
            child: Text('pushName跳转Search'),
          ),
        ],
      ),
    );
  }
}
