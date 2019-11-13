import 'package:bloc/bloc.dart';
import 'package:subastapp/ui/login/login_events.dart';
import 'package:subastapp/ui/login/login_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{

    @override
    LoginState get initialState => LoginStateDefault();

    @override
    Stream<LoginState> mapEventToState(LoginState state,LoginEvent event) async* {

    }

}