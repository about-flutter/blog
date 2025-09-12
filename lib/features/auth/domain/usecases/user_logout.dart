import 'package:blog/core/error/failures.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Use case for logging out the current user
class UserLogout implements UseCase<void, NoParams> {
  final SupabaseClient _supabaseClient;

  UserLogout(this._supabaseClient);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    try {
      await _supabaseClient.auth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }
}
