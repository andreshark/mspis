import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mspis/features/presentation/bloc/test/test_bloc.dart';
import 'package:mspis/features/presentation/bloc/test/test_state.dart';
import 'package:mspis/features/presentation/pages/home_page.dart';
import '../widgets/loader.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestBloc, TestState>(builder: (context, state) {
      if (state is TestLoading) {
        return const Loader();
      }

      return _buildbody(context, state);
    });
  }

  Widget _buildbody(BuildContext context, TestState state) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leading: SizedBox.shrink(),
              title: Text(
                'Тест завершен',
                //style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${state.totalScore} из ${state.maxScore} баллов',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'целостность знаний - ${(state.chl! * 100).round()}%',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'полнотa знаний - ${(state.pol! * 100).round()}%',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'умения  - ${(state.u! * 100).round()}%',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Spacer(),
                  Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Align(
                        alignment: Alignment.center,
                        child: FilledButton(
                            onPressed: () {
                              Navigator.of(
                                context,
                                rootNavigator: true,
                              ).pushReplacement(MaterialPageRoute(
                                builder: (context) {
                                  return TablesPage();
                                },
                              ));
                            },
                            child: Text('Вернуться на главную страницу')),
                      ))
                ],
              ),
            )));
  }
}
