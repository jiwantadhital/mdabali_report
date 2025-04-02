import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mdabali_report/data/models/member_limit_model.dart';
import 'package:mdabali_report/data/repos/repositories/member_limit_repository.dart';

part 'member_limit_event.dart';
part 'member_limit_state.dart';

class MemberLimitBloc extends Bloc<MemberLimitEvent, MemberLimitState> {
  final MemberLimitRepository memberLimitRepository;
  MemberLimitBloc(this.memberLimitRepository) : super(MemberLimitInitial()) {
    on<FetchMemberLimit>(onFetchMemberLimit);
  }

  Future<void> onFetchMemberLimit(
      FetchMemberLimit event, Emitter<MemberLimitState> emit) async {
    emit(MemberLimitLoading());
    try {
      final data = await memberLimitRepository.fetchMemberLimitData();
      emit(MemberLimitLoaded(memeberLimitModel: data));
    } catch (e) {
      emit(MemberLimitError(e.toString()));
    }
  }
}
