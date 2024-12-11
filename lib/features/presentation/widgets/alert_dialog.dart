import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mspis/features/presentation/bloc/test/test_bloc.dart';
import 'package:mspis/features/presentation/bloc/test/test_event.dart';

import '../bloc/auth/auth_bloc.dart';

Future<void> emptyAnswerDialog(BuildContext context, TestBloc testBloc) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Не на все вопросы дан ответ'),
        content: const Text(
          'Вы уверены, что хотите завершить тест?',
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor),
            child: const Text('Дa', style: TextStyle(color: Colors.white)),
            onPressed: () {
              testBloc.add(EndTest(
                  userId:
                      BlocProvider.of<AuthBloc>(context).state.userEntity!.id));
            },
          ),
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.red),
            child: const Text(
              'Нет',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
