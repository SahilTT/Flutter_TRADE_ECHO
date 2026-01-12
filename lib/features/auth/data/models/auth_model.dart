import '../../domain/entities/auth_entity.dart';

class AuthModel extends UserEntity {
  const AuthModel({
    required super.id,
    required super.email,
    required super.fullname,
    required super.isTermsAccepted,
    super.accessToken,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      fullname: json['fullname'] ?? '',
      isTermsAccepted: json['isTermsAccepted'] ?? false,
      accessToken: json['accessToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullname': fullname,
      'isTermsAccepted': isTermsAccepted,
      'accessToken': accessToken,
    };
  }
}
