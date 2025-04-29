import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mdabali_report/data/models/init_model.dart';
import 'package:mdabali_report/data/repos/repositories/init_repository.dart';

part 'init_event.dart';
part 'init_state.dart';

class InitBloc extends Bloc<InitEvent, InitState> {
  final InitRepository initRepository;
  InitBloc(this.initRepository) : super(InitInitial()) {
    on<FetchInitData>(onFetchInitData);
  }

  Future<void> onFetchInitData(
      FetchInitData event, Emitter<InitState> emit) async {
    emit(InitLoading());
    try {
      final initModel = await initRepository.fetchInitData();
      if (initModel.status == true) {
        emit(InitLoaded(initModel: initModel));
      } else {
        emit(InitFailure(error: initModel.message.toString()));
      }
    } catch (e) {
      emit(InitFailure(error: e.toString()));
    }
  }
}
