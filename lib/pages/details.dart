import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final int id;

  const DetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailsPage();
}

class _DetailsPage extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('详情页面')),
      body: Center(child: Text('详情id ${widget.id}')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 返回上一页
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
