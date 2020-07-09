import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/authentication/authentication.dart';
import 'package:flutter_login/home/home.dart';
import 'package:flutter_login/home/test_page.dart';
import 'package:flutter_login/login/login_page.dart';
import 'package:flutter_login/navigation/bloc/appdrawer_bloc.dart';
import 'package:flutter_login/splash/splash.dart';
import 'package:user_repository/user_repository.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..add(AuthenticationStarted());
      },
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatefulWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationSuccess) {
              _navigator.pushAndRemoveUntil(
                AuthenticatedRoot.route(),
                (route) => false,
              );
            }
            if (state is AuthenticationFailure) {
              _navigator.pushAndRemoveUntil(
                LoginPage.route(userRepository: widget.userRepository),
                (route) => false,
              );
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) {
        return SplashPage.route();
      },
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
              TestPage.route(),
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
