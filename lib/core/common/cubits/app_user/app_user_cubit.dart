import 'dart:async';
import 'package:blog/core/common/entities/user.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'app_user_state.dart';

@immutable
class AppUserCubit extends Cubit<AppUserState> {
  final AuthBloc authBloc;
  late final StreamSubscription _authSubscription;

  AppUserCubit(this.authBloc) : super(AppUserInitial()) {
    _authSubscription = authBloc.stream.listen((state) {
      if (state is AuthSuccess) {
        emit(AppUserLoggedIn(state.user));
      } else if (state is AuthFailure) {
        emit(AppUserInitial());
      } else if (state is AuthLoading) {
        emit(AppUserLoading());
      }
    });
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
