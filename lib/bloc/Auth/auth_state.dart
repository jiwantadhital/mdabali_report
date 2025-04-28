import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  List<Object> get props=>[];
}

class AuthAuthenticated extends AuthState{

}

class AuthUnauthenticated extends AuthState{
String? message;
AuthUnauthenticated({this.message});
List<Object> get props=>[message ?? ''];
}