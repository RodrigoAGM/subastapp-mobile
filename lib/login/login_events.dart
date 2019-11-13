import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LoginEvent extends Equatable{}

class LoginEventSignIn extends LoginEvent{
  @override
  String toString() => 'LoginEventSignIn';
}

class LoginEventSignOut extends LoginEvent{
  @override
  String toString() => 'LoginEventSignOut';
}

class LoginEventInitSignIn extends LoginEvent{
  @override
  String toString() => 'LoginEventInitSignIn';
}

class LoginEventRegister extends LoginEvent{
  @override
  String toString() => 'LoginEventInitSignIn';
}