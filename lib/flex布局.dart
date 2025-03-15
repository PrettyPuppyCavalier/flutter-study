import 'package:flutter/material.dart';

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
        body: CustomWidget(),
      ),
    ),
  );
}

class CustomWidget extends StatelessWidget {
  CustomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Row和Column都继承flex组件，所以可以直接在Row中使用Expanded
        Row(
          children: [
            Expanded(
              // 设置flex后子元素宽度自适应，子元再设置宽度是没有效果的
              flex: 2,
              child: IconContainer(Icons.apple, color: Colors.yellow, size: 40),
            ),
            Expanded(
              flex: 1,
              child: IconContainer(Icons.android, color: Colors.red, size: 40),
            ),
          ],
        ),
        SizedBox(height: 40),
        SizedBox(
          height: 600,
          // Flex布局外层需要有个容器宽高
          child: Flex(
            // direction 设置横向布局或者纵向布局
            direction: Axis.vertical,
            children: [
              Expanded(
                // 设置flex后子元素宽度自适应，子元再设置宽度是没有效果的
                flex: 2,
                child: IconContainer(
                  Icons.apple,
                  color: Colors.yellow,
                  size: 40,
                ),
              ),
              Expanded(
                flex: 1,
                child: IconContainer(
                  Icons.android,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
        Row(
          children: [
            SizedBox(width: 20),
            // 类似flex1
            Expanded(
              // 输入框
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '请输入',
                ),
              ),
            ),
            SizedBox(width: 20),
            ClipRRect(
              // 设置圆角
              borderRadius: BorderRadius.circular(20),
              child: IconContainer(
                Icons.search,
                color: Colors.yellow,
                size: 40,
              ),
            ),
          ],
        ),
        SizedBox(height: 40),
        Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Image.asset('assets/images/img.jpg', fit: BoxFit.cover),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                // 类似flex1
                Expanded(
                  flex: 3,
                  // 输入框
                  child: SizedBox(
                    height: 100,
                    child: IconContainer(
                      Icons.ac_unit_rounded,
                      color: Colors.yellow,
                      size: 40,
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 100,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: double.infinity,
                            child: Image.asset(
                              'assets/images/img.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: double.infinity,
                            child: Image.asset(
                              'assets/images/img.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class IconContainer extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;

  IconContainer(this.icon, {Key? key, required this.color, required this.size})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 80,
      height: 80,
      decoration: BoxDecoration(color: color),
      child: Center(child: Icon(icon, color: Colors.white, size: size)),
    );
  }
}
