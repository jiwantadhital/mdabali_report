part of 'summary_report_bloc.dart';

sealed class SummaryReportEvent extends Equatable {
  const SummaryReportEvent();

  @override
  List<Object> get props => [];
}

class FetchSummaryReport extends SummaryReportEvent {
  final String dateFrom;
  final String dateTo;
  final String clientId;

  const FetchSummaryReport(
      {required this.dateFrom, required this.dateTo, required this.clientId});
}
