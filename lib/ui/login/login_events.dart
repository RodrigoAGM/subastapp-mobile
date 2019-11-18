import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LoginEvent extends Equatable{}

class LoginEventSignIn extends LoginEvent{

  final BuildContext context;
  final String email;
  final String pass;

  LoginEventSignIn(this.context, this.email, this.pass);

  @override
  String toString() => 'LoginEventSignIn';
}

class LoginEventSignOut extends LoginEvent{
  @override
  String toString() => 'LoginEventSignOut';
}

class LoginEventInitSignIn extends LoginEvent{

  final BuildContext context;

  LoginEventInitSignIn(this.context);

  @override
  String toString() => 'LoginEventInitSignIn';
}