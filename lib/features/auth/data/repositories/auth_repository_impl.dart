import 'package:blog/core/error/failures.dart';
import 'package:blog/core/network/connection_checker.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog/core/common/entities/user.dart';
import 'package:blog/features/auth/data/models/user_model.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  const AuthRepositoryImpl(this.remoteDataSource, this.connectionChecker);
  @override
  Future<Either<Failure, User>> logInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.logInWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure('No internet connection'));
      }
      final user = await fn();
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = remoteDataSource.currentSession;
        if (session == null) {
          return left(Failure('User not logged in !'));
        }
        return right(UserModel(
          id: session.user.id
        , email: session.user.email ?? ''
        , name: '',
        ));
      }
      final user = await remoteDataSource.getCurrentUser();
      if (user == null) {
        return left(Failure('User not logged in !'));
      }
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
