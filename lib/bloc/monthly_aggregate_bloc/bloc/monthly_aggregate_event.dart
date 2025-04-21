part of 'monthly_aggregate_bloc.dart';

sealed class MonthlyAggregateEvent extends Equatable {
  const MonthlyAggregateEvent();

  @override
  List<Object> get props => [];
}

class FetchMonthlyAggregate extends MonthlyAggregateEvent {}
