import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mdabali_report/data/models/summary_report_model.dart';
import 'package:mdabali_report/data/repos/repositories/summary_report_repository.dart';

part 'summary_report_event.dart';
part 'summary_report_state.dart';

class SummaryReportBloc extends Bloc<SummaryReportEvent, SummaryReportState> {
  final SummaryReportRepository summaryReportRepository;
  SummaryReportBloc(this.summaryReportRepository)
      : super(SummaryReportInitial()) {
    on<FetchSummaryReport>(onFetchSummaryReport);
  }

  Future<void> onFetchSummaryReport(
      FetchSummaryReport event, Emitter<SummaryReportState> emit) async {
    emit(SummaryReportLoading());
    try {
      final data = await summaryReportRepository.fetchSummaryReport(
          dateFrom: event.dateFrom, dateTo: event.dateTo,clientId: event.clientId);
      data.status == true
          ? emit(SummaryReportLoaded(data))
          : emit(SummaryReportError(data.message.toString()));
    } catch (e) {
      emit(SummaryReportError(e.toString()));
    }
  }
}
