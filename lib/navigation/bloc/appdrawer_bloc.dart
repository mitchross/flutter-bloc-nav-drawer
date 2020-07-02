import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'appdrawer_event.dart';
part 'appdrawer_state.dart';

class AppdrawerBloc extends Bloc<AppdrawerEvent, AppdrawerState> {

final GlobalKey<NavigatorState> navigatorKey;

  AppdrawerBloc(this.navigatorKey);

  @override
  AppdrawerState get initialState => AppdrawerInitial();

  @override
  Stream<AppdrawerState> mapEventToState(
    AppdrawerEvent event,
  ) async* {
        if (event is NavigatorEventPop) {
      navigatorKey.currentState.pop();
    }
    else if( event is HomePageEvent)
    {
      navigatorKey.currentState.pushNamed('/home');

    }
      else if( event is TestPageEvent)
    {
      navigatorKey.currentState.pushNamed('/testPage');

    }
  }
}
