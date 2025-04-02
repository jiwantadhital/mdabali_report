part of 'topup_summary_bloc.dart';

sealed class TopupSummaryEvent extends Equatable {
  const TopupSummaryEvent();

  @override
  List<Object> get props => [];
}

class FetchTopupSummary extends TopupSummaryEvent {}
