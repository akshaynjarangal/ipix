part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  
  @override
  List<Object> get props => [identityHashCode(this)];
}

class AuthenticationInitial extends AuthenticationState {
    @override
  List<Object> get props => [identityHashCode(this)];
}

class AuthenticationLoading extends AuthenticationState{
    @override
  List<Object> get props => [identityHashCode(this)];
}

class AuthenticationSuccess extends AuthenticationState{
    @override
  List<Object> get props => [identityHashCode(this)];
}

class AuthenticationFailed extends AuthenticationState{
    @override
  List<Object> get props => [identityHashCode(this)];
}

class AuthenticationLogout extends AuthenticationState{
    @override
  List<Object> get props => [identityHashCode(this)];
}