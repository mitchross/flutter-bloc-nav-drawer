import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'appdrawer_event.dart';
part 'appdrawer_state.dart';

class AppdrawerBloc extends Bloc<AppdrawerEvent, AppdrawerState> {
  @override
  AppdrawerState get initialState => AppdrawerState.homePage;

  @override
  Stream<AppdrawerState> mapEventToState(
    AppdrawerEvent event,
  ) async* {
    if (event is HomePageEvent) {
      yield AppdrawerState.homePage;
    } else if (event is TestPageEvent) {
      yield AppdrawerState.testPage;
    }
  }
}
