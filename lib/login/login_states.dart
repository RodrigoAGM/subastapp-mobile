import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class LoginState extends Equatable{
  LoginState([List props = const []]) : super(props);
}

class LoginStateDefault extends LoginState{
  
  @override
  String toString() => 'LoginStateDefault';
}

class LoginStateLoading extends LoginState{
  
  @override
  String toString() => 'LoginStateLoading';
}

class LoginStateError extends LoginState{
  
  @override
  String toString() => 'LoginStateError';
}

class LoginStateLoggedIn extends LoginState{
  
  @override
  String toString() => 'LoginStateLoggedIn';
}