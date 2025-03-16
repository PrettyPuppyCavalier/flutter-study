import 'package:flutter/material.dart';

class School extends StatefulWidget {
  const School({Key? key}) : super(key: key);

  @override
  State<School> createState() => _SchoolState();
}

class _SchoolState extends State<School> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('school page'),
      ),
    );
  }
}