part of 'init_bloc.dart';

sealed class InitState extends Equatable {
  const InitState();

  @override
  List<Object> get props => [];
}

final class InitInitial extends InitState {}

class InitLoading extends InitState {}

class InitLoaded extends InitState {
  final InitModel initModel;

  const InitLoaded({required this.initModel});
}

class InitFailure extends InitState {
  final String error;

  const InitFailure({required this.error});
}
