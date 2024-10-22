part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure({required this.message});
}

class AuthVisibilityChanged extends AuthState {
  final bool isVisible;

  AuthVisibilityChanged(this.isVisible);
}

class AuthSignedOut extends AuthState {}
