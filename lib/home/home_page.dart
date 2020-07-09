import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/authentication/authentication.dart';
import 'package:flutter_login/navigation/app_drawer.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      drawer: AppDrawer(),
      body: Center(
        child: RaisedButton(
          child: Text('logout'),
          onPressed: () {
            context.bloc<AuthenticationBloc>().add(AuthenticationLoggedOut());
          },
        ),
      ),
    );
  }
}
