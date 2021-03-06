import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'appdrawer_event.dart';
part 'appdrawer_state.dart';

class AppdrawerBloc extends Bloc<AppdrawerEvent, AppdrawerState> {
  AppdrawerBloc() : super(AppdrawerState.homePage);

  @override
  Stream<AppdrawerState> mapEventToState(
    AppdrawerEvent event,
  ) async* {
    if (event is HomePageEvent) {
      yield AppdrawerState.homePage;
    } else if (event is SamplePageEvent) {
      yield AppdrawerState.testPage;
    }
  }
}
