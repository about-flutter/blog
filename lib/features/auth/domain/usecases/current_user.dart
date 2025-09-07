

import 'package:blog/core/error/failures.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/core/common/entities/user.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';


class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository repository;
  CurrentUser(this.repository);
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
   
    return await repository.currentUser();
  }
 
}
