import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class RegisterEvent extends Equatable{}

class RegisterEventRegister extends RegisterEvent{
  @override
  String toString() => 'RegisterEventSignIn';
}