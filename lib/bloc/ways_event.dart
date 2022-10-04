part of 'ways_bloc.dart';

abstract class WaysEvent extends Equatable {
  const WaysEvent();

  @override
  List<Object> get props => [];
}

class WaysNoneEvent extends WaysEvent {}

class WaysInitialScreen extends WaysEvent {}

class WaysGetData extends WaysEvent {
  final String url;
  WaysGetData({required this.url});

  @override
  List<Object> get props => [url];
}

class WaysCalculate extends WaysEvent {}
