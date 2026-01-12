import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String fullname;
  final bool isTermsAccepted;
  final String? accessToken;

  const UserEntity({
    required this.id,
    required this.email,
    required this.fullname,
    required this.isTermsAccepted,
    this.accessToken,
  });

  @override
  List<Object?> get props => [
    id,
    email,
    fullname,
    isTermsAccepted,
    accessToken,
  ];
}
