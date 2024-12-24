import 'package:clean_architecture/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.password,
  });

  // Converts UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
    };
  }

  // Creates a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  // Overrides the toString method
  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, password: $password)';
  }
}
