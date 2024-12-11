import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mspis/features/presentation/bloc/local_data/local_data_bloc.dart';
import 'package:mspis/features/presentation/bloc/local_data/local_data_event.dart';
import '../../../injection_container.dart';
import '../bloc/local_data/local_data_state.dart';
import '../bloc/test/test_bloc.dart';
import '../bloc/test/test_event.dart';
import '../pages/curse_lec.dart';
import '../pages/test_page.dart';

Widget themeSreen(BuildContext context, LocalDataState state) {
  return ListView(
      padding: EdgeInsets.all(10),
      children: List.generate(
          state.themes!.length,
          (int index) => Card.outlined(
                child: ListTile(
                  title: Text(state.themes![index]['name']!),
                  onTap: () {
                    Navigator.of(
                      context,
                      rootNavigator: true,
                    ).push(MaterialPageRoute(builder: (context) {
                      return LecPage(id: index);
                    }));
                  },
                ),
              )));
}
