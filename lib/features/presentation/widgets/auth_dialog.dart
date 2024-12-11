import 'package:flutter/material.dart';

Future<void> AuthDialog(BuildContext context, String message) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Ошибка входа в аккаунт'),
        content: Text(
          message,
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor),
            child: const Text('ОК', style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
