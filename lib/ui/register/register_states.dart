import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class RegisterState extends Equatable{
  RegisterState([List props = const []]) : super(props);
}

class RegisterStateDefault extends RegisterState{
  
  @override
  String toString() => 'RegisterStateDefault';
}

class RegisterStateLoading extends RegisterState{
  
  @override
  String toString() => 'RegisterStateLoading';
}

class RegisterStateError extends RegisterState{
  
  @override
  String toString() => 'RegisterStateError';
}

class RegisterStateRegistered extends RegisterState{
  
  @override
  String toString() => 'RegisterStateLoggedIn';
}