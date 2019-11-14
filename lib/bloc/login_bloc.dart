import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:subastapp/network/customer_api.dart';
import 'package:subastapp/ui/init_screens/splash_screen.dart';
import 'package:subastapp/ui/login/login_events.dart';
import 'package:subastapp/ui/login/login_states.dart';
import 'package:flutter/foundation.dart';
import 'package:page_transition/page_transition.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{

    @override
    LoginState get initialState => LoginStateDefault(false);

    final _customerApi = new CustomerApi();

    @override
    Stream<LoginState> mapEventToState(LoginState state,LoginEvent event) async* {
      if (event is LoginEventSignIn){
            yield* _mapSignInEvent(event);
      }
    }

    Stream<LoginState> _mapSignInEvent (LoginEventSignIn event) async*{
      try{
        yield LoginStateLoading();
        var result = await _customerApi.login(event.email, event.pass);
        debugPrint(result.toString());
        if(result == null) {
          yield LoginStateError();
        }else if (result.id == "not found") {
          yield LoginStateDefault(true);
        }else{
          Navigator.pushReplacement(event.context, PageTransition(type: PageTransitionType.fade, child: Splash()));
        }
      }catch(e){
        debugPrint(e.toString());
        yield LoginStateError();
      }
    }

}