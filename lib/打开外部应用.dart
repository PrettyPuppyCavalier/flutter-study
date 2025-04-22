import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(
  MaterialApp(
    home: SafeArea(
      child: Material(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                child: Text('打开外部网页'),
                onPressed: () async {
                  final Uri _url = Uri.parse('https://flutter.dev');
                  if (await canLaunchUrl(_url)) {
                    await launchUrl(_url);
                  }
                },
              ),
              ElevatedButton(
                child: Text('拨打电话'),
                onPressed: () async {
                  final Uri tel = Uri.parse('tel:10086');
                  if (await canLaunchUrl(tel)) {
                    await launchUrl(tel);
                  } else {
                    throw 'Could not launch $tel';
                  }
                },
              ),
              ElevatedButton(
                child: Text('发送短信'),
                onPressed: () async {
                  final Uri tel = Uri.parse('sms:10086');
                  if (await canLaunchUrl(tel)) {
                    await launchUrl(tel);
                  } else {
                    throw 'Could not launch $tel';
                  }
                },
              ),
              ElevatedButton(
                child: const Text('打开外部应用-支付宝'),
                onPressed: () async {
                  final Uri alipays = Uri.parse('alipays://');
                  if (await canLaunchUrl(alipays)) {
                    await launchUrl(alipays);
                  } else {
                    throw 'Could not launch $alipays';
                  }
                },
              ),
              ElevatedButton(
                child: const Text('打开外部应用-微信'),
                onPressed: () async {
                  final Uri weixin = Uri.parse('weixin://');
                  if (await canLaunchUrl(weixin)) {
                    await launchUrl(weixin);
                  } else {
                    throw 'Could not launch $weixin';
                  }
                },
              ),
              ElevatedButton(
                child: const Text('打开外部应用-高德地图'),
                onPressed: () async {
                  String title = "北京大学";
                  String latitude = "39.992806";
                  String longitude = "116.310905";
                  Uri uri = Uri.parse(
                    '${Platform.isAndroid ? 'android' : 'ios'}amap://navi?sourceApplication=amap&lat=$latitude&lon=$longitude&dev=0&style=2&poiname=${title}',
                  );
                  try {
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      print('无法调起高德地图');
                    }
                  } catch (e) {
                    print('无法调起高德地图');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ),
  ),
);
