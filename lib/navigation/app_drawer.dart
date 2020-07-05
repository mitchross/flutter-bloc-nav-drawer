import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/authentication/authentication.dart';
import 'package:flutter_login/home/home_page.dart';
import 'package:flutter_login/home/test_page.dart';
import 'package:flutter_login/navigation/bloc/appdrawer_bloc.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
   return  BlocProvider(
        create: (_) => AppdrawerBloc(_navigatorKey), child: _AppDrawer());
        
  }
}

class _AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppdrawerBloc appdrawerBloc = BlocProvider.of<AppdrawerBloc>(context);
     final AuthenticationBloc authenticationBloc =
          BlocProvider.of<AuthenticationBloc>(context);

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
                    title: Text("Page 1"),
                    onTap: () {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        // close the app drawer
                        Navigator.of(context).pop();

                        BlocProvider.of<AppdrawerBloc>(context)
                            .add(TestPageEvent());
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.group),
                    title: Text("Home"),
                    onTap: () {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        // close the app drawer
                        Navigator.of(context).pop();
                        BlocProvider.of<AppdrawerBloc>(context)
                            .add(HomePageEvent());
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Logout'),
                    onTap: () {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        // close the app drawer
                           Navigator.of(context).pop();
                          authenticationBloc.add(AuthenticationLoggedOut());
                      });
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

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/testPage':
        return MaterialPageRoute(builder: (_) => TestPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
