part of 'sms_summary_bloc.dart';

sealed class SmsSummaryEvent extends Equatable {
  const SmsSummaryEvent();

  @override
  List<Object> get props => [];
}

class FetchSmsSummary extends SmsSummaryEvent {}
