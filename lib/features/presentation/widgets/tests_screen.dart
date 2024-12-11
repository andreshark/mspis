import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../injection_container.dart';
import '../bloc/local_data/local_data_state.dart';
import '../bloc/test/test_bloc.dart';
import '../bloc/test/test_event.dart';
import '../pages/test_page.dart';

Widget testsSreen(BuildContext context, LocalDataState state) {
  return ListView(
    padding: EdgeInsets.all(10),
    children: List.generate(
      state.tests!.length,
      (int index) => Card.outlined(
          child: ListTile(
              title: Text(state.tests![index]['name']!),
              onTap: () {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).push(MaterialPageRoute(
                  builder: (context) {
                    return BlocProvider<TestBloc>(
                        create: (context) =>
                            TestBloc(sl(), sl(), state.tests![index]['id'])
                              ..add(LoadTest(id: state.tests![index]['id'])),
                        child: const TestPage());
                  },
                ));
              })),
    ),
  );
}
