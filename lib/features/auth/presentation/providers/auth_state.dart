import 'package:equatable/equatable.dart';
import 'package:medrep_pro/features/auth/domain/entities/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthOtpSent extends AuthState {
  final String emailOrPhone;
  final bool isPhone;

  const AuthOtpSent(this.emailOrPhone, {required this.isPhone});

  @override
  List<Object?> get props => [emailOrPhone, isPhone];
}

class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthSessionLocked extends AuthState {
  final User user;

  const AuthSessionLocked(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
