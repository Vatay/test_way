part of 'ways_bloc.dart';

abstract class WaysState extends Equatable {
  const WaysState();

  @override
  List<Object> get props => [];
}

class WaysInitial extends WaysState {}

class WaysWaitEvents extends WaysState {}

class WaysStartData extends WaysState {
  final String url;
  WaysStartData({required this.url});

  @override
  List<Object> get props => [url];
}

class WaysLoading extends WaysState {}

class WaysLoaded extends WaysState {
  final List<Ways> waysList;
  WaysLoaded({required this.waysList});

  @override
  List<Object> get props => [waysList];
}

class WaysError extends WaysState {
  final String error;

  WaysError(this.error);

  @override
  List<Object> get props => [error];
}
