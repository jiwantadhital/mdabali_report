part of 'member_limit_bloc.dart';

sealed class MemberLimitState extends Equatable {
  const MemberLimitState();

  @override
  List<Object> get props => [];
}

final class MemberLimitInitial extends MemberLimitState {}

class MemberLimitLoading extends MemberLimitState {}

class MemberLimitLoaded extends MemberLimitState {
  final MemeberLimitModel memeberLimitModel;

  const MemberLimitLoaded({required this.memeberLimitModel});
}

class MemberLimitError extends MemberLimitState {
  final String error;

  const MemberLimitError(this.error);
}
