part of 't_otp_bloc.dart';

sealed class TOtpEvent extends Equatable {
  const TOtpEvent();

  @override
  List<Object> get props => [];
}

class VerifyOtpEvent extends TOtpEvent {
  final String secret;
  final String otp;

  const VerifyOtpEvent({required this.secret, required this.otp});

  @override
  List<Object> get props => [secret, otp];
}
