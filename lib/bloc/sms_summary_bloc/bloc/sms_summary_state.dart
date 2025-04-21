part of 'sms_summary_bloc.dart';

sealed class SmsSummaryState extends Equatable {
  const SmsSummaryState();

  @override
  List<Object> get props => [];
}

final class SmsSummaryInitial extends SmsSummaryState {}

class SmsSummaryLoading extends SmsSummaryState {}

class SmsSummaryLoaded extends SmsSummaryState {
  final SmsSummaryModel smsSummaryModel;

  const SmsSummaryLoaded({required this.smsSummaryModel});
}

class SmsSummaryError extends SmsSummaryState {
  final String error;

  const SmsSummaryError(this.error);
}
