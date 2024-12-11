import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mspis/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:mspis/features/presentation/bloc/test/test_bloc.dart';
import 'package:mspis/features/presentation/bloc/test/test_event.dart';
import 'package:mspis/features/presentation/pages/test_page.dart';
import 'package:mspis/features/presentation/widgets/results_screen.dart';
import 'package:mspis/features/presentation/widgets/tests_screen.dart';
import '../../../injection_container.dart';
import '../bloc/local_data/local_data_bloc.dart';
import '../bloc/local_data/local_data_event.dart';
import '../bloc/local_data/local_data_state.dart';
import '../widgets/loader.dart';
import '../widgets/themes_screen.dart';

class TablesPage extends StatefulWidget {
  const TablesPage({super.key});

  @override
  State<TablesPage> createState() => _TablesPageState();
}

class _TablesPageState extends State<TablesPage> {
  int currentPageIndex = 0;
  List<String> pages = ['Темы', 'Результаты'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalDataBloc, LocalDataState>(
        builder: (context, state) {
      if (state is LocalDataLoading) {
        BlocProvider.of<LocalDataBloc>(context).add(ReadTables(
            user: BlocProvider.of<AuthBloc>(context).state.userEntity!));
        return const Loader();
      }

      return _buildbody(context, state);
    });
  }

  Widget _buildbody(BuildContext context, LocalDataState state) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: state.inTests! && currentPageIndex == 0
            ? IconButton(
                onPressed: () {
                  return BlocProvider.of<LocalDataBloc>(context)
                      .add(BackToThemes());
                },
                icon: Icon(Icons.arrow_back_ios_new))
            : SizedBox.shrink(),
        title: Text(state.inTests! && currentPageIndex == 0
            ? 'Тесты'
            : pages[currentPageIndex]),
      ),
      bottomNavigationBar:
          BlocProvider.of<AuthBloc>(context).state.userEntity!.role == 2
              ? null
              : NavigationBar(
                  onDestinationSelected: (int index) {
                    setState(() {
                      currentPageIndex = index;
                    });
                  },
                  indicatorColor: Colors.amber,
                  selectedIndex: currentPageIndex,
                  destinations: const <Widget>[
                    NavigationDestination(
                      icon: Icon(Icons.library_books_outlined),
                      label: 'Темы',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.bookmark_outline_outlined),
                      label: 'Результаты',
                    ),
                  ],
                ),
      body: BlocProvider.of<AuthBloc>(context).state.userEntity!.role == 2
          ? resultsScreen(context, state)
          : <Widget>[
              state.inTests!
                  ? testsSreen(context, state)
                  : themeSreen(context, state),
              resultsScreen(context, state)
            ][currentPageIndex],
    ));
  }
}
