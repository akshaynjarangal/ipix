import 'package:akshaytest/src/logic/authentication/authentication_bloc.dart';
import 'package:akshaytest/src/screens/home/home.dart';
import 'package:akshaytest/src/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final authBloc = AuthenticationBloc();
  authBloc.add(CheckAuth());
  runApp(MyApp(authBloc: authBloc));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.authBloc});
  final AuthenticationBloc authBloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => authBloc,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Restaurants',
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationSuccess) {
                return const Home();
              } else if (state is AuthenticationLogout||state is AuthenticationFailed) {
                return Login();
              } else {
                return const Scaffold(body: Center(child: CircularProgressIndicator()));
              }
            },
          )),
    );
  }
}
