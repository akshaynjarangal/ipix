part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class UserLogin extends AuthenticationEvent{
  final String username;
  final String password;
  const UserLogin({required this.username, required this.password});
}

class UserLogout extends AuthenticationEvent{}

class CheckAuth extends AuthenticationEvent{}