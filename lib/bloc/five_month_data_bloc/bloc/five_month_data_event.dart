part of 'five_month_data_bloc.dart';

sealed class FiveMonthDataEvent extends Equatable {
  const FiveMonthDataEvent();

  @override
  List<Object> get props => [];
}

class FetchFiveMonthData extends FiveMonthDataEvent {
  final String toDate;
  const FetchFiveMonthData({required this.toDate});
}
