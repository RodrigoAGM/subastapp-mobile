import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:subastapp/network/customer_api.dart';
import 'package:subastapp/ui/login/login_screen.dart';
import 'package:subastapp/ui/register/register_events.dart';
import 'package:subastapp/ui/register/register_states.dart';
import 'package:page_transition/page_transition.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{

  @override
  RegisterState get initialState => RegisterStateDefault();

  final _customerApi = new CustomerApi();

  @override
  Stream<RegisterState> mapEventToState(RegisterState state, RegisterEvent event) async*{
    if (event is RegisterEventRegister){
      yield* _mapRegisterEvent(event);
    }
  }

  Stream<RegisterState> _mapRegisterEvent (RegisterEventRegister event) async*{
    try{
      yield RegisterStateLoading();
      var result = await _customerApi.register(event.name, event.email, event.password);
      debugPrint(result.toString());
      if(result == null) {
        yield RegisterStateError();
      }else{
        Navigator.pushReplacement(event.context, PageTransition(type: PageTransitionType.fade, child: LoginPage()));
      }
    }catch(e){
      yield RegisterStateError();
    }
  }

}