import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mdabali_report/data/models/topup_summary_model.dart';
import 'package:mdabali_report/data/repos/repositories/topup_summary_repository.dart';

part 'topup_summary_event.dart';
part 'topup_summary_state.dart';

class TopupSummaryBloc extends Bloc<TopupSummaryEvent, TopupSummaryState> {
  final TopupSummaryRepository topupSummaryRepository;
  TopupSummaryBloc(this.topupSummaryRepository) : super(TopupSummaryInitial()) {
    on<FetchTopupSummary>(onFetchTopupSummary);
  }

  Future<void> onFetchTopupSummary(
      FetchTopupSummary event, Emitter<TopupSummaryState> emit) async {
    emit(TopupSummaryLoading());
    try {
      final data = await topupSummaryRepository.fetchTopupSummaryData();
      data.status == true
          ? emit(TopupSummaryLoaded(topupSummaryModel: data))
          : emit(TopupSummaryError(error: data.message.toString()));
    } catch (e) {
      emit(TopupSummaryError(error: e.toString()));
    }
  }
}
