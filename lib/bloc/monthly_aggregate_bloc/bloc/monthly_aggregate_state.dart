part of 'monthly_aggregate_bloc.dart';

sealed class MonthlyAggregateState extends Equatable {
  const MonthlyAggregateState();

  @override
  List<Object> get props => [];
}

final class MonthlyAggregateInitial extends MonthlyAggregateState {}

class MonthlyAggregateLoading extends MonthlyAggregateState {}

// Success state with data
class MonthlyAggregateLoaded extends MonthlyAggregateState {
  final MonthlyAggregateModel monthlyAggregate;

  const MonthlyAggregateLoaded(this.monthlyAggregate);
}

// Error state
class MonthlyAggregateError extends MonthlyAggregateState {
  final String error;

  const MonthlyAggregateError(this.error);
}
