import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mspis/features/presentation/pages/home_page.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';
import '../widgets/auth_dialog.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          if (state is LoginFailed) {
            AuthDialog(context, state.errorMessage!);
          } else if (state is LoginSuccess) {
            Navigator.of(
              context,
              rootNavigator: true,
            ).pushReplacement(MaterialPageRoute(builder: (context) {
              return const TablesPage();
            }));
          }
        }, builder: (context, state) {
          return _buildBody(context);
        }));
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Авторизация',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 34),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Эл.почта:',
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email не может быть пустым';
                          }
                          return null;
                        },
                        decoration:
                            const InputDecoration(hintText: 'Ivanov@mail.ru'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Пароль:',
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Пароль не может быть пустым';
                          }
                          if (value.length < 3) {
                            return 'Пароль должен содержать в себе хотя бы 3 символов';
                          }
                          return null;
                        },
                        controller: _passwordController,
                        decoration: const InputDecoration(hintText: 'fe}21!'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      (BlocProvider.of<AuthBloc>(context).state
                              is LoginChecking)
                          ? const SizedBox(
                              width: 40,
                              height: 40,
                              child: Center(
                                  child: CircularProgressIndicator.adaptive()),
                            )
                          : FilledButton(
                              onPressed: () => validateAndLogin(),
                              child: const Text('Продолжить')),
                    ])),
          ),
          Align(
              alignment: Alignment.center,
              child: Opacity(
                opacity: 0.08,
                child: Image.asset(
                  'assets/KNITU.jpg',
                  width: 400,
                  height: 400,
                ),
              ))
        ])));
  }

  void validateAndLogin() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      print('Form is valid');
      BlocProvider.of<AuthBloc>(context).add(Login(
          email: _emailController.text, password: _passwordController.text));
    } else {
      print('Form is invalid');
    }
  }
}
