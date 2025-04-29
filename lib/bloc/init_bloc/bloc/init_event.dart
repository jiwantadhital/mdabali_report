part of 'init_bloc.dart';

sealed class InitEvent extends Equatable {
  const InitEvent();

  @override
  List<Object> get props => [];
}

class FetchInitData extends InitEvent {}
