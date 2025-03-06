import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter Demo Home Page')),
        body: Column(children: [
          const CustomWidget(),
          const MyButton()
        ],),
      ),
    ),
  );
}

class CustomWidget extends StatelessWidget {
  const CustomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 100,
        alignment: Alignment.bottomRight,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(2, 2),
              blurRadius: 4
            )
          ],
          border: Border.all(
            color: Colors.black,
            width: 2
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.red,
              Colors.yellow,
              Colors.green
            ]
          )
        ),
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        child: Text('自定义组件', style: TextStyle(color: Colors.white),),
      ),
    );
  }
}

class MyButton extends StatelessWidget{
  const MyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 40 ,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text('自定义组件', style: TextStyle(color: Colors.white)),
    );
  }
}