import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable{

List<Object> get props=> [];
}
class CheckAuthStatus extends AuthEvent{
  
}

class LogoutEvent extends AuthEvent{

}