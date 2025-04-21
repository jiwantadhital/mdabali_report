part of 'member_limit_bloc.dart';

sealed class MemberLimitEvent extends Equatable {
  const MemberLimitEvent();

  @override
  List<Object> get props => [];
}

class FetchMemberLimit extends MemberLimitEvent {}
