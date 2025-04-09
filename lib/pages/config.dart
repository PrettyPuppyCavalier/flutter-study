import 'package:flutter/material.dart';

class ConfigPage extends StatefulWidget {
  final Map arguments ;

  const ConfigPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConfigPage();
}

class _ConfigPage extends State<ConfigPage> {
  @override
  void initState() {
    super.initState();
    print(widget.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('配置页面')),
      body: Center(child: Text('配置id ${widget.arguments['id']}')),
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
