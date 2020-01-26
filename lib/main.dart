import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_test/core/bloc/login_bloc/bloc.dart';

import 'core/ui/screen/login_screen.dart';

main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
        child: LoginScreen(),
      ),
    );
  }
}