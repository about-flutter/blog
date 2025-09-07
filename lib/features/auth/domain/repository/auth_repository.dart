import 'package:blog/core/error/failures.dart';
import 'package:blog/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name ,
    required String email ,
    required String password
  });
   Future<Either<Failure, User>> logInWithEmailPassword({
    required String email ,
    required String password
  });
  Future<Either<Failure, User>> currentUser();
}
