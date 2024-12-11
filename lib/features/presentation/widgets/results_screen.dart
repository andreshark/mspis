import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mspis/features/domain/entities/results.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/local_data/local_data_state.dart';

Widget resultsScreen(BuildContext context, LocalDataState state) {
  return BlocProvider.of<AuthBloc>(context).state.userEntity!.role == 2
      ? ListView(
          padding: EdgeInsets.all(10),
          children: List.generate(state.users!.length, (int index) {
            return Card.outlined(
              child: ExpansionTile(
                  title: Text(state.users![index].name),
                  controlAffinity: ListTileControlAffinity.leading,
                  children: List.generate(state.themes!.length, (int index3) {
                    List<Map<String, dynamic>> tests = state.allTests!
                        .where((Map<String, dynamic> test) =>
                            test['theme_id'] == state.themes![index3]['id'])
                        .toList();
                    List<ResultEntity> hui1 = state.results!
                        .where((element) =>
                            element.userId == state.users![index].id)
                        .where((element) => tests
                            .map((el) => el['id'])
                            .contains(element.testId))
                        .toList();
                    return ThemeCards(
                        context, state, hui1, index3, tests, index);
                  })),
            );
          }))
      : ListView(
          padding: EdgeInsets.all(10),
          children: List.generate(state.themes!.length, (int index) {
            List<Map<String, dynamic>> tests = state.allTests!
                .where((Map<String, dynamic> test) =>
                    test['theme_id'] == state.themes![index]['id'])
                .toList();
            List<ResultEntity> hui1 = state.results!
                .where((element) =>
                    tests.map((el) => el['id']).contains(element.testId))
                .toList();
            return Card.outlined(
                child: ThemeCards(context, state, hui1, index, tests, null));
          }));
}

Widget ThemeCards(
    BuildContext context,
    LocalDataState state,
    List<ResultEntity> hui1,
    int index,
    List<Map<String, dynamic>> tests,
    int? index52) {
  return ExpansionTile(
      title: Text(state.themes![index]['name']),
      controlAffinity: ListTileControlAffinity.leading,
      children: [
            hui1.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.all(10),
                    child: SfCartesianChart(
                        title: ChartTitle(
                            text: 'Общие знания за курс',
                            textStyle: TextStyle(fontWeight: FontWeight.bold),
                            alignment: ChartAlignment.center,
                            borderColor: Colors.transparent,
                            borderWidth: 0),
                        // Initialize category axis
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(
                          maximum: 1,
                        ),
                        series: <CartesianSeries<_ChartData, String>>[
                          ColumnSeries<_ChartData, String>(
                              // Bind data source
                              dataSource: [
                                _ChartData(
                                    Colors.green,
                                    "CHL",
                                    hui1
                                            .map((element) => element.chl)
                                            .reduce((a, b) => a + b) /
                                        hui1.length),
                                _ChartData(
                                    Colors.orangeAccent,
                                    "POL",
                                    hui1
                                            .map((element) => element.pol)
                                            .reduce((a, b) => a + b) /
                                        hui1.length),
                                _ChartData(
                                    Colors.purpleAccent,
                                    "U",
                                    hui1
                                            .map((element) => element.u)
                                            .reduce((a, b) => a + b) /
                                        hui1.length),
                              ],
                              xValueMapper: (_ChartData result, _) => result.x,
                              yValueMapper: (_ChartData result, _) => result.y,
                              pointColorMapper: (_ChartData data, _) =>
                                  data.color,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)))
                        ]))
                : SizedBox.fromSize()
          ] +
          List.generate(tests.length, (int index1) {
            List<ResultEntity> hui = BlocProvider.of<AuthBloc>(context)
                        .state
                        .userEntity!
                        .role ==
                    2
                ? state.results!
                    .where(
                      (element) =>
                          element.testId == tests[index1]['id'] &&
                          state.users![index52!].id == element.userId,
                    )
                    .toList()
                : state.results!
                    .where((element) => element.testId == tests[index1]['id'])
                    .toList();
            if (hui.isNotEmpty) {
              ResultEntity curResult = hui.first;
              return Padding(
                  padding: EdgeInsets.all(10),
                  child: SfCartesianChart(
                      title: ChartTitle(
                          text: tests[index1]['name'],
                          textStyle: TextStyle(fontWeight: FontWeight.bold),
                          alignment: ChartAlignment.center,
                          borderColor: Colors.transparent,
                          borderWidth: 0),
                      // Initialize category axis
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                        maximum: 1,
                      ),
                      series: <CartesianSeries<_ChartData, String>>[
                        ColumnSeries<_ChartData, String>(
                            // Bind data source
                            dataSource: [
                              _ChartData(Colors.green, "CHL", curResult.chl),
                              _ChartData(
                                  Colors.orangeAccent, "POL", curResult.pol),
                              _ChartData(Colors.purpleAccent, "U", curResult.u),
                            ],
                            xValueMapper: (_ChartData result, _) => result.x,
                            yValueMapper: (_ChartData result, _) => result.y,
                            pointColorMapper: (_ChartData data, _) =>
                                data.color,
                            borderRadius: BorderRadius.all(Radius.circular(12)))
                      ]));
            }
            return Padding(
              padding: EdgeInsets.all(15),
              child: Text('No data'),
            );
          }));
}

class _ChartData {
  _ChartData(this.color, this.x, this.y);
  final Color color;
  final String x;
  final double y;
}
