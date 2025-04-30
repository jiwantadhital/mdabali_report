import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:mdabali_report/data/models/init_model.dart';
import 'package:mdabali_report/data/repos/repositories/init_repository.dart';
import 'package:mdabali_report/resources/constants.dart';

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
      // Fetch image using clientId

      final initModel = await initRepository.fetchInitData();
      if (initModel.status == true) {
        final imageUrl = Uri.parse(
            '${ApiClass.testUrl}/gateway/webApi/client/image/${initModel.data?.clientId.toString()}');
        final response = await http.get(imageUrl);

        if (response.statusCode != 200) {
          throw Exception("Failed to fetch image");
        }
        final imageBytes = response.bodyBytes;
        emit(InitLoaded(initModel: initModel, imageBytes: imageBytes));
      } else {
        emit(InitFailure(error: initModel.message.toString()));
      }
    } catch (e) {
      emit(InitFailure(error: e.toString()));
    }
  }
}
