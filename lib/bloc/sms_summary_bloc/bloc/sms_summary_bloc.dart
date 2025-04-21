import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mdabali_report/data/models/sms_summary_model.dart';
import 'package:mdabali_report/data/repos/repositories/sms_summary_repository.dart';

part 'sms_summary_event.dart';
part 'sms_summary_state.dart';

class SmsSummaryBloc extends Bloc<SmsSummaryEvent, SmsSummaryState> {
  final SmsSummaryRepository smsSummaryRepository;
  SmsSummaryBloc(this.smsSummaryRepository) : super(SmsSummaryInitial()) {
    on<FetchSmsSummary>(onFetchSmsSummary);
  }

  Future<void> onFetchSmsSummary(
      FetchSmsSummary event, Emitter<SmsSummaryState> emit) async {
    emit(SmsSummaryLoading());
    try {
      final data = await smsSummaryRepository.fetchSmsSummaryData();

      data.status == true
          ? emit(SmsSummaryLoaded(smsSummaryModel: data))
          : emit(SmsSummaryError(data.message.toString()));
    } catch (e) {
      emit(SmsSummaryError(e.toString()));
    }
  }
}
