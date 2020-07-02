part of 'appdrawer_bloc.dart';

abstract class AppdrawerEvent extends Equatable {
  const AppdrawerEvent();
     @override
  List<Object> get props => [];
}
class NavigatorEventPop extends AppdrawerEvent {
}

class HomePageEvent extends AppdrawerEvent {

}

class TestPageEvent extends AppdrawerEvent {

}