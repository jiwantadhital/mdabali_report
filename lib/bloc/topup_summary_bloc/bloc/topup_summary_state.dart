part of 'topup_summary_bloc.dart';

sealed class TopupSummaryState extends Equatable {
  const TopupSummaryState();

  @override
  List<Object> get props => [];
}

final class TopupSummaryInitial extends TopupSummaryState {}

class TopupSummaryLoading extends TopupSummaryState {}

class TopupSummaryLoaded extends TopupSummaryState {
  final TopupSummaryModel topupSummaryModel;

  const TopupSummaryLoaded({required this.topupSummaryModel});
}

class TopupSummaryError extends TopupSummaryState {
  final String error;

  const TopupSummaryError({required this.error});
}
