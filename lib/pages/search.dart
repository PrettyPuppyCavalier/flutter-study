import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final int id;

  const SearchPage({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('搜索页面')),
      body: Center(child: Text('搜索id ${widget.id}')),
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
