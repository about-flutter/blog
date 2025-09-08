import 'package:blog/core/error/exceptions.dart';
import 'package:blog/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentSession;

  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> logInWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<UserModel> logInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw ServerException('User is null');
      }
      return UserModel.fromJson(response.user!.toJson()).copyWith(
        email: currentSession!.user.email,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );
      if (response.user == null) {
        throw ServerException('User is null');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Session? get currentSession => supabaseClient.auth.currentSession;

  @override
Future<UserModel?> getCurrentUser() async {
  try {
    // Kiểm tra session
    final session = currentSession;
    if (session == null) return null;
    
    // Query profiles table
    final userData = await supabaseClient
        .from('profiles')
        .select()
        .eq('id', session.user.id)
        .single(); // Lấy 1 record
    
    // Convert to UserModel
    return UserModel.fromJson(userData);
    
  } catch (e) {
    throw ServerException(e.toString());
  }
}
}
