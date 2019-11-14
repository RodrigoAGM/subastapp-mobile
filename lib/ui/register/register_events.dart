import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class RegisterEvent extends Equatable{}

class RegisterEventRegister extends RegisterEvent{

  final BuildContext context;
  final String name;
  final String password;
  final String email;

  RegisterEventRegister(this.context, this.name, this.email, this.password);

  @override
  String toString() => 'RegisterEventSignIn';
}
