import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mdabali_report/data/models/five_month_data_model.dart';
import 'package:mdabali_report/data/repos/repositories/five_month_data_repository.dart';

part 'five_month_data_event.dart';
part 'five_month_data_state.dart';

class FiveMonthDataBloc extends Bloc<FiveMonthDataEvent, FiveMonthDataState> {
  final FiveMonthDataRepository fiveMonthDataRepository;
  FiveMonthDataBloc(this.fiveMonthDataRepository)
      : super(FiveMonthDataInitial()) {
    on<FetchFiveMonthData>(onFetchFiveMonthData);
  }

  Future<void> onFetchFiveMonthData(
      FetchFiveMonthData event, Emitter<FiveMonthDataState> emit) async {
    emit(FiveMonthDataLoading());
    try {
      final data = await fiveMonthDataRepository.fetchFiveMonthData(
          toDate: event.toDate);
      data.status == true
          ? emit(FiveMonthDataLoaded(data: data))
          : emit(FiveMonthDataError(message: data.message.toString()));
    } catch (e) {
      emit(FiveMonthDataError(message: e.toString()));
    }
  }
}
