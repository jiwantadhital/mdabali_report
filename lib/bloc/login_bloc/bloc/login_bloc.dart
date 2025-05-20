import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdabali_report/data/models/login_model.dart';
import 'package:mdabali_report/data/repos/repositories/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  LoginBloc(this.loginRepository) : super(LoginInitial()) {
    on<LoginButtonPressed>(onLoginButtonPressed);
  }

  Future<void> onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final response =
          await loginRepository.login(event.username, event.password);
      if (response.status == true) {
        emit(LoginSuccess(loginModel: response));
      } else {
        emit(LoginFailure(error: response.message ?? 'Failed to login'));
      }
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
