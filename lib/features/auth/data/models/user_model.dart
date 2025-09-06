import 'package:blog/features/auth/domain/entities/user.dart';

class UserModel extends User {

  UserModel({
   required super.id,
    required super.name,
    required super.email,
  }) ;
  factory UserModel.fromJson(Map<String, dynamic> map) {
  return UserModel(
    id: map['id'] ?? 'unknown-user',
    name: map['name'] ?? 'Unknown User', 
    email: map['email'] ?? 'no-email@example.com',
  );
}
}
