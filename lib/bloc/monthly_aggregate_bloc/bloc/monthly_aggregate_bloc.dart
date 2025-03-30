import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mdabali_report/data/models/monthly_aggregate_model.dart';
import 'package:mdabali_report/data/repos/repositories/monthly_aggreagate_repository.dart';

part 'monthly_aggregate_event.dart';
part 'monthly_aggregate_state.dart';

class MonthlyAggregateBloc
    extends Bloc<MonthlyAggregateEvent, MonthlyAggregateState> {
  final MonthlyAggregateRepository repository;
  MonthlyAggregateBloc(this.repository) : super(MonthlyAggregateInitial()) {
    on<FetchMonthlyAggregate>(_onFetchMonthlyAggregate);
  }

  Future<void> _onFetchMonthlyAggregate(
      FetchMonthlyAggregate event, Emitter<MonthlyAggregateState> emit) async {
    emit(MonthlyAggregateLoading());
    try {
      final data = await repository.fetchMonthlyAggregate();
      print('data: $data');
      emit(MonthlyAggregateLoaded(data));
      //   data.status == true
      //       ? emit(MonthlyAggregateLoaded(data))
      //       : emit(MonthlyAggregateError(data.message ?? 'Something went wrong'));
    } catch (e) {
      emit(MonthlyAggregateError(e.toString()));
      print('error : ${e}');
    }
  }
}
