import 'package:bloc/bloc.dart';
import 'package:flutter_ais_register/bloc/auth_event.dart';
import 'package:flutter_ais_register/bloc/auth_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<RegisterUserEvent>(_onRegisterUserEvent);
  }

  Future<void> _onRegisterUserEvent(
    RegisterUserEvent event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(RegistrationLoading());

    await Future.delayed(Duration(seconds: 1));

    emit(RegistrationSuccess());
  }
}
