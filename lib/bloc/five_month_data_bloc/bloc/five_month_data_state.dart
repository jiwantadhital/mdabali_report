part of 'five_month_data_bloc.dart';

sealed class FiveMonthDataState extends Equatable {
  const FiveMonthDataState();

  @override
  List<Object> get props => [];
}

final class FiveMonthDataInitial extends FiveMonthDataState {}

class FiveMonthDataLoading extends FiveMonthDataState {}

class FiveMonthDataLoaded extends FiveMonthDataState {
  final FiveMonthDataModel data;
  const FiveMonthDataLoaded({required this.data});
}

class FiveMonthDataError extends FiveMonthDataState {
  final String message;
  const FiveMonthDataError({required this.message});
}
