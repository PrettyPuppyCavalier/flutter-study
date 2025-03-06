import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter Demo Home Page')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // 本地加载
              Image.asset('assets/images/img.jpg'),
              // 网络加载
              Image.network(
                'https://img.uuuui.com/file/019a6044069fa49a0cb9b-a2469279acbe0a0ecd.png',
              ),
              Container(
                width: 300,
                height: 200,
                color: Colors.blue,
                child: Image.network(
                  'https://img.uuuui.com/file/97203cc834b7e7ef1870a-3b9ab85c70ca3922ae.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: 300,
                height: 200,
                color: Colors.blue,
                child: Image.network(
                  'https://img.uuuui.com/file/97203cc834b7e7ef1870a-3b9ab85c70ca3922ae.jpg',
                ),
              ),


              // 圆形图片 方式1
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://img.uuuui.com/file/97203cc834b7e7ef1870a-3b9ab85c70ca3922ae.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // 圆形图片 方式2
              ClipOval(
                child: Image.network(
                  'https://img.uuuui.com/file/97203cc834b7e7ef1870a-3b9ab85c70ca3922ae.jpg',
                  fit: BoxFit.cover,
                  width: 150,
                  height: 150,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
