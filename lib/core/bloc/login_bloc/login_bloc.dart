import 'package:bloc/bloc.dart';
import 'package:login_test/core/model/login/login_repo.dart';
import 'package:login_test/core/utils/validators.dart';

import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepo _loginRepo;

  LoginBloc() {
    _loginRepo = LoginRepo();
  }

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // TODO: implement mapEventToState
    if (event is EmailChanged) {
      yield* _handleEmailChanged(event.email);
    } else if (event is PasswordChanged) {
      yield* _handlePasswordChanged(event.password);
    } else if (event is LoginWithCredentials) {
      yield* _handleLoginWithCredentials(
          email: event.email, password: event.password);
    }
  }

  Stream<LoginState> _handleEmailChanged(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<LoginState> _handlePasswordChanged(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<LoginState> _handleLoginWithCredentials(
      {String email, String password}) async* {
    yield LoginState.loading();
    try {
      bool result = await _loginRepo.login(email, password);
      if (result) {
        print('STATE SUCESS - 1');
        yield LoginState.success();
      } else {
        print('STATE FAILED LOGIN - 2');
        yield LoginState.failure();
      }
    } catch (_) {
      print('STATE FAILED LOGIN - 3');
      yield LoginState.failure();
    }
  }
}
