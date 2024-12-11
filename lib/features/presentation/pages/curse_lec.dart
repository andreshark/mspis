import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/local_data/local_data_bloc.dart';
import '../bloc/local_data/local_data_event.dart';

class LecPage extends StatefulWidget {
  const LecPage({super.key, required this.id});

  final int id;
  @override
  State<LecPage> createState() => _LecPageState();
}

class _LecPageState extends State<LecPage> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(resizeToAvoidBottomInset: false, body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                title: Text(BlocProvider.of<LocalDataBloc>(context)
                    .state
                    .themes![widget.id]['name'])),
            body: Center(
                child: Column(children: [
              Container(
                width: 600,
                height: 400,
                child: Image.asset(
                    widget.id != 1 ? 'assets/12.png' : 'assets/11.png'),
              ),
              SizedBox(
                height: 20,
              ),
              FilledButton(
                  onPressed: () {
                    BlocProvider.of<LocalDataBloc>(context)
                        .add(ChooseTheme(themeId: widget.id));
                    Navigator.of(
                      context,
                      rootNavigator: true,
                    ).pop();
                  },
                  child: Text("Перейти к тестам"))
            ]))));
  }
}
