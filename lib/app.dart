import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/authentication/authentication.dart';
import 'package:flutter_login/home/home.dart';
import 'package:flutter_login/home/sample_page.dart';
import 'package:flutter_login/navigation/bloc/appdrawer_bloc.dart';

import 'package:flutter_login/splash/splash.dart';
import 'package:user_repository/user_repository.dart';

import 'login/view/login_page.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
    @required this.userRepository,
  })  : assert(authenticationRepository != null),
        assert(userRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  AuthenticatedRoot.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}

class AuthenticatedRoot extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (_) => AppdrawerBloc(),
        child: AuthenticatedRoot(),
      ),
    );
  }

  @override
  _AuthenticatedRootState createState() => _AuthenticatedRootState();
}

class _AuthenticatedRootState extends State<AuthenticatedRoot> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppdrawerBloc, AppdrawerState>(
      listener: (context, state) {
        switch (state) {
          case AppdrawerState.testPage:
            _navigator.pushAndRemoveUntil(
              SamplePage.route(),
              (route) => route.isFirst,
            );
            break;
          case AppdrawerState.homePage:
            _navigator.popUntil((route) => route.isFirst);
            break;
        }
      },
      child: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (_) => HomePage.route(),
      ),
    );
  }
}
