import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthCubitState {}

class AuthCubitInitial extends AuthCubitState {}

final class SignUpLoadingState extends AuthCubitState {}

final class SignUpSuccessStat extends AuthCubitState {}

final class FailedToSignUpState extends AuthCubitState {
  final String message;
  FailedToSignUpState({required this.message});
}

final class LoginLoadingState extends AuthCubitState {}

final class LoginSuccessState extends AuthCubitState {}

final class FailedToLoginState extends AuthCubitState {
  final String message;
  FailedToLoginState({required this.message});
}
