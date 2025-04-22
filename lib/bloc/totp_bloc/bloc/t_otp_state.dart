part of 't_otp_bloc.dart';

sealed class TOtpState extends Equatable {
  const TOtpState();

  @override
  List<Object> get props => [];
}

final class TOtpInitial extends TOtpState {}

class TOtpLoading extends TOtpState {}

class TOtpSuccess extends TOtpState {
  final TOtpModel tOtpModel;

  const TOtpSuccess({required this.tOtpModel});
  @override
  List<Object> get props => [tOtpModel];
}

class TOtpFailure extends TOtpState {
  final String error;

  const TOtpFailure({required this.error});
}
