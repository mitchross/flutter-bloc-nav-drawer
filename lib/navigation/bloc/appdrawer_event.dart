part of 'appdrawer_bloc.dart';

abstract class AppdrawerEvent extends Equatable {
  const AppdrawerEvent();
  @override
  List<Object> get props => [];
}

class HomePageEvent extends AppdrawerEvent {}

class SamplePageEvent extends AppdrawerEvent {}
