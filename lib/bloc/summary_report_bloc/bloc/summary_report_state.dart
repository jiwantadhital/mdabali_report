part of 'summary_report_bloc.dart';

sealed class SummaryReportState extends Equatable {
  const SummaryReportState();

  @override
  List<Object> get props => [];
}

final class SummaryReportInitial extends SummaryReportState {}

class SummaryReportLoading extends SummaryReportState {}

class SummaryReportLoaded extends SummaryReportState {
  final SummaryReportModel summaryReportModel;

  const SummaryReportLoaded(this.summaryReportModel);
}

class SummaryReportError extends SummaryReportState {
  final String error;

  const SummaryReportError(this.error);
}
