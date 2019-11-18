import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:subastapp/network/customer_api.dart';
import 'package:subastapp/ui/home/home_screen.dart';
import 'package:subastapp/ui/login/login_screen.dart';
import 'package:subastapp/ui/register/register_events.dart';
import 'package:subastapp/ui/register/register_states.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{

  @override
  RegisterState get initialState => RegisterStateDefault();

  final _customerApi = new CustomerApi();
  final _storage = new FlutterSecureStorage();

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
      if(result == null) {
        yield RegisterStateError();
      }else{

        try{
          yield RegisterStateLoading();
          var loginResult = await _customerApi.login(event.email, event.password);

          if(loginResult == null) {
            yield RegisterStateError();
          }else{
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('show', false);
            await _storage.write(key: 'token', value: loginResult.token);
            await _storage.write(key: 'userId', value: loginResult.id);
            await _storage.write(key: 'email', value: loginResult.email);
            await _storage.write(key: 'pass', value: loginResult.password);
            await _storage.write(key: 'store', value: loginResult.storeId);
            Navigator.pushReplacement(event.context, PageTransition(type: PageTransitionType.fade, child: MainPage()));
          }
        }catch(e){
          yield RegisterStateError();
        }
      }
    }catch(e){
      yield RegisterStateError();
    }
  }

}