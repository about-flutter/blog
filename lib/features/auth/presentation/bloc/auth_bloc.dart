import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/core/common/entities/user.dart';
import 'package:blog/features/auth/domain/usecases/current_user.dart';
import 'package:blog/features/auth/domain/usecases/user_login.dart';
import 'package:blog/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
  }) : _userSignUp = userSignUp,
       _userLogin = userLogin,
       _currentUser = currentUser,
       super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final result = await _currentUser(const NoParams());
      result.fold(
        (l) => emit(AuthFailure(l.message)),
        (user) => _emitAuthSuccess(user, emit),
      );
    } catch (e) {
      // log if you have a logger
      emit(const AuthFailure('Unable to check current user'));
    }
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await _userSignUp(
        UserSignUpParams(
          email: event.email,
          password: event.password,
          name: event.name,
        ),
      );
      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => _emitAuthSuccess(user, emit),
      );
    } catch (e) {
      emit(const AuthFailure('Sign up failed'));
    }
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await _userLogin(
        UserLoginParams(email: event.email, password: event.password),
      );
      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => _emitAuthSuccess(user, emit),
      );
    } catch (e) {
      emit(const AuthFailure('Login failed'));
    }
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    emit(AuthSuccess(user));
  }
}
