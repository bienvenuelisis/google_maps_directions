import 'package:flutter/material.dart';

void pushToAndRemoveAll(BuildContext context, Widget page) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (_) => page,
    ),
    (_) => false,
  );
}

Future pushTo<T>(BuildContext context, Widget page, [bool replace = false]) {
  if (replace) {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  } else {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }
}

void pop(BuildContext context) {
  Navigator.of(context).pop();
}
