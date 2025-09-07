import 'package:blog/core/common/entities/user.dart';

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
UserModel copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
