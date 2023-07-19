import 'package:akshaytest/src/data/services/authentication_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<UserLogin>((event, emit) async{
      emit(AuthenticationLoading());
      final response = await AuthenticationService.login(username: event.username, password: event.password);
      if(response){
        emit(AuthenticationSuccess());
      }else{
        emit(AuthenticationFailed());
      }
    });

    on<UserLogout>((event, emit)async {
      final response = await AuthenticationService.logout;
      if(response){
        add(CheckAuth());
      }else{
        emit(AuthenticationFailed());
      }
    });

    on<CheckAuth>((event, emit) async{
      final response = await AuthenticationService.checkAuth;
      if(response){
        emit(AuthenticationSuccess());
      }else{
        emit(AuthenticationFailed());
      }
    });
  }
}
