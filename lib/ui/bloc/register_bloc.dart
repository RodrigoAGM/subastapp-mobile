import 'package:bloc/bloc.dart';
import 'package:subastapp/ui/register/register_events.dart';
import 'package:subastapp/ui/register/register_states.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{

  @override
  RegisterState get initialState => RegisterStateDefault();

  @override
  Stream<RegisterState> mapEventToState(RegisterState state, RegisterEvent event) async*{

  }

}