import 'package:bloc/bloc.dart';
import 'package:mdabali_report/bloc/Auth/auth_event.dart';
import 'package:mdabali_report/bloc/Auth/auth_state.dart';
import 'package:mdabali_report/data/shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState> {
  final String id = DateTime.now().toString(); 
  AuthBloc():super(AuthUnauthenticated()){
    on<LogoutEvent>(_onLogoutEvent);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }


Future<void> _onLogoutEvent(LogoutEvent event,Emitter<AuthState>emit)async{
  print('AuthBloc: Handling LogoutEvent');
  UserSimplePreferences.cleanToken();
  print('AuthBloc: Emitting AuthUnauthenticated with message');
  emit(AuthUnauthenticated(message:'Session Expired. Please Login again' ));
}
Future<void> _onCheckAuthStatus(CheckAuthStatus event, Emitter<AuthState>emit)async{
print('AuthBloc: Checking auth status');
final token= UserSimplePreferences.getToken();

if(token!=null && token.isNotEmpty){
  print('AuthBloc: Token found, emitting AuthAuthenticated');
  emit(AuthAuthenticated());
}
else{
 print('AuthBloc: No token, emitting AuthUnauthenticated');
  emit(AuthUnauthenticated());
}
}
}