import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/authentication/authentication.dart';
import 'package:flutter_login/navigation/bloc/appdrawer_bloc.dart';



class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 8.0),
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.group),
                    title: Text("Sample Page"),
                    onTap: () {
                      context.bloc<AppdrawerBloc>().add(SamplePageEvent());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.group),
                    title: Text("Home"),
                    onTap: () {
                      context.bloc<AppdrawerBloc>().add(HomePageEvent());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Logout'),
                    onTap: () {
                      context
                          .bloc<AuthenticationBloc>()
                          .add(AuthenticationLogoutRequested());
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
