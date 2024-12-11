import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mspis/features/domain/entities/answer.dart';
import 'package:mspis/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:mspis/features/presentation/bloc/test/test_bloc.dart';
import 'package:mspis/features/presentation/bloc/test/test_event.dart';
import 'package:mspis/features/presentation/bloc/test/test_state.dart';
import 'package:mspis/features/presentation/pages/result_page.dart';
import '../bloc/local_data/local_data_bloc.dart';
import '../bloc/local_data/local_data_event.dart';
import '../bloc/local_data/local_data_state.dart';
import '../widgets/alert_dialog.dart';
import '../widgets/loader.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestBloc, TestState>(listener: (context, state) {
      if (state is TestResults) {
        BlocProvider.of<LocalDataBloc>(context).add(ReadTables(
            user: BlocProvider.of<AuthBloc>(context).state.userEntity!));
        Navigator.of(
          context,
          rootNavigator: true,
        ).push(MaterialPageRoute(
          builder: (context1) {
            return BlocProvider.value(
              value: BlocProvider.of<TestBloc>(context),
              child: const ResultPage(),
            );
          },
        ));
      }
    }, builder: (context, state) {
      if (state is TestLoading || state is TestResults) {
        return const Loader();
      }

      return _buildbody(context, state);
    });
  }

  Widget _buildbody(BuildContext context, TestState state) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.questions!.length,
                      itemBuilder: (context, index) => GestureDetector(
                            child: SizedBox(
                                width: 50,
                                child: Card(
                                  color: state.questionNum == index
                                      ? Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.7)
                                      : state.questions![index].curAnswer ==
                                              null
                                          ? Colors.white
                                          : Colors.grey.shade300,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text((index + 1).toString()),
                                  ),
                                )),
                            onTap: () {
                              BlocProvider.of<TestBloc>(context)
                                  .add(ChooseQuestion(questionNum: index));
                            },
                          ))),
              SizedBox(
                height: 20,
              ),
              Text(
                  'Осталось времени: ${state.remaining!.inHours != 0 ? ' ${state.remaining!.inHours % 24} часов' : ''}${state.remaining!.inMinutes != 0 ? ' ${state.remaining!.inMinutes % 60} минут' : ''}${state.remaining!.inSeconds != 0 ? ' ${state.remaining!.inSeconds % 60} секунд' : ''}'),
              Text(
                state.questions![state.questionNum!].description,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
              SizedBox(
                height: 20,
              ),
            ] +
            List.generate(
              state.questions![state.questionNum!].answers.length,
              (int index) => ListTile(
                title: Text(state
                    .questions![state.questionNum!].answers[index].description),
                leading: Radio<AnswerEntity>(
                  value: state.questions![state.questionNum!].answers[index],
                  groupValue: state.questions![state.questionNum!].curAnswer,
                  onChanged: (AnswerEntity? value) {
                    BlocProvider.of<TestBloc>(context)
                        .add(ChooseAnswer(answer: value!));
                  },
                ),
              ),
            ) +
            [
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.center,
                child: FilledButton(
                    onPressed: () {
                      state.questions!.length - 1 != state.questionNum
                          ? BlocProvider.of<TestBloc>(context).add(
                              ChooseQuestion(
                                  questionNum: state.questionNum! + 1))
                          : {
                              (state.questions!.indexWhere((element) =>
                                          element.curAnswer == null) ==
                                      -1)
                                  ? BlocProvider.of<TestBloc>(context).add(
                                      EndTest(
                                          userId:
                                              BlocProvider.of<AuthBloc>(context)
                                                  .state
                                                  .userEntity!
                                                  .id))
                                  : emptyAnswerDialog(context,
                                      BlocProvider.of<TestBloc>(context))
                            };
                    },
                    child: Text(state.questions!.length - 1 != state.questionNum
                        ? 'Следующий вопрос'
                        : 'Завершить тестирование')),
              )
            ],
      ),
    )));
  }
}
