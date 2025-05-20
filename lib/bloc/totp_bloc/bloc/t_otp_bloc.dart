import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mdabali_report/data/models/totp_model.dart';
import 'package:mdabali_report/data/repos/repositories/totp_repository.dart';

part 't_otp_event.dart';
part 't_otp_state.dart';

class TOtpBloc extends Bloc<TOtpEvent, TOtpState> {
  final TotpRepository totpRepository;
  TOtpBloc(this.totpRepository) : super(TOtpInitial()) {
    on<VerifyOtpEvent>(onVerifyOtpEvent);
  }

  Future<void> onVerifyOtpEvent(
      VerifyOtpEvent event, Emitter<TOtpState> emit) async {
    emit(TOtpLoading());
    try {
      final response = await totpRepository.verifyOtp(event.secret, event.otp);
      if (response.status == true) {
        emit(TOtpSuccess(tOtpModel: response));
      } else {
        emit(TOtpFailure(error: response.message ?? 'Failed to verify OTP'));
      }
    } catch (e) {
      emit(TOtpFailure(error: e.toString()));
    }
  }
}
