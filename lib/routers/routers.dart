// ios风格路由
import 'package:flutter/cupertino.dart';
import '../pages/home.dart';
import '../pages/config.dart';

Map routers = {
  '/home': (context, {arguments}) => HomePage(),
  '/config': (context, {arguments}) => ConfigPage(arguments: arguments),
};

var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  final Function? pageContentBuilder = routers[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = CupertinoPageRoute(
        builder:
            (context) =>
            pageContentBuilder(
              context,
              arguments: settings.arguments as Map,
            ),
      );

      return route;
    } else {
      final Route route = CupertinoPageRoute(
        builder: (context) => pageContentBuilder(context),
      );
      return route;
    }
  }

  return null;
};