import 'package:flutter/material.dart';

Future push(BuildContext context, Widget page, {bool replace = false}) {
  if (replace) {
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }

  return Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) {
    return page;
  }));
}

bool pop<T extends Object>(BuildContext context, [T? result]) {
  if (Navigator.canPop(context)) {
    Navigator.pop(context, result);
    return true;
  }
  return false;
}

Future pushNamed(BuildContext context, String routeName, {bool replace = false, Object? args}) {
  if (replace) {
    return Navigator.pushReplacementNamed(context, routeName, arguments: args);
  }

  return Navigator.pushNamed(context, routeName, arguments: args);
}

bool popAndPushedName<T extends Object>(BuildContext context, String routeName, { bool replace = false, Object? args}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if(replace){
      Navigator.restorablePopAndPushNamed(context, routeName, arguments: args);
    }
    else {
      Navigator.popAndPushNamed(context, routeName, arguments: args);
    }
  });

  return true;
}
