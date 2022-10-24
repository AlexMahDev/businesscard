import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/repositories/auth_repository.dart';
import '../../../setupInjection.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(UnAuthenticated()) {
    on<SignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await getIt<AuthRepository>()
            .signIn(email: event.email, password: event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    on<SignUpRequested>((event, emit) async {
      emit(Loading());
      try {
        await getIt<AuthRepository>()
            .signUp(email: event.email, password: event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      await getIt<AuthRepository>().signOut();
      emit(UnAuthenticated());
    });
  }
}
