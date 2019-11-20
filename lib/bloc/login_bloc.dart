import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:subastapp/network/customer_api.dart';
import 'package:subastapp/ui/home/home_screen.dart';
import 'package:subastapp/ui/login/login_events.dart';
import 'package:subastapp/ui/login/login_states.dart';
import 'package:flutter/foundation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginStateDefault(false);
  final _storage = new FlutterSecureStorage();

  final _customerApi = new CustomerApi();

  @override
  Stream<LoginState> mapEventToState(
      LoginState state, LoginEvent event) async* {
    if (event is LoginEventSignIn) {
      yield* _mapSignInEvent(event);
    } else if (event is LoginEventInitSignIn) {
      yield* _mapInitSignInEvent(event);
    }
  }

  Stream<LoginState> _mapSignInEvent(LoginEventSignIn event) async* {
    try {
      yield LoginStateLoading();
      var result = await _customerApi.login(event.email, event.pass);

      if (result == null) {
        yield LoginStateError();
      } else if (result.id == "not found") {
        yield LoginStateDefault(true);
      } else {
        debugPrint(result.toString());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('show', false);
        await _storage.write(key: 'token', value: result.token);
        await _storage.write(key: 'userId', value: result.id);
        await _storage.write(key: 'email', value: result.email);
        await _storage.write(key: 'pass', value: result.password);
        await _storage.write(key: 'store', value: result.storeId);

        Navigator.pushReplacement(event.context,
            PageTransition(type: PageTransitionType.fade, child: MainPage()));
      }
    } catch (e) {
      debugPrint(e.toString());
      yield LoginStateError();
    }
  }

  Stream<LoginState> _mapInitSignInEvent(LoginEventInitSignIn event) async* {
    try {
      yield LoginStateLoading();
      var email = await _storage.read(key: 'email');
      var pass = await _storage.read(key: 'pass');

      if (email != null && pass != null) {
        var result = await _customerApi.login(email, pass);
        debugPrint(result.toString());

        if (result == null) {
          yield LoginStateDefault(false);
        } else if (result.id == "not found") {
          yield LoginStateDefault(false);
        } else {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('show', false);
          await _storage.write(key: 'token', value: result.token);

          Navigator.pushReplacement(event.context,
              PageTransition(type: PageTransitionType.fade, child: MainPage()));
        }
      } else {
        yield LoginStateDefault(false);
      }
    } catch (e) {
      debugPrint(e.toString());
      yield LoginStateError();
    }
  }
}
