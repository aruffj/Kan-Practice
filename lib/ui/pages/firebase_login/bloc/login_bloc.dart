import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kanpractice/core/firebase/queries/authentication.dart';
import 'package:kanpractice/ui/pages/firebase_login/login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginStateIdle());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginSubmitting) yield* _mapLoadedToState(event);
    else if (event is LoginIdle) yield* _mapIdleToState();
    else if (event is CloseSession) yield* _mapCloseSessionToState();
    else if (event is RemoveAccount) yield* _mapRemoveAccountToState(event);
    else if (event is ChangePassword) yield* _mapChangePasswordToState(event);
  }

  Stream<LoginState> _mapLoadedToState(LoginSubmitting event) async* {
    yield LoginStateLoading();
    final error = await AuthRecords.instance.handleLogIn(event.mode, event.email, event.password);
    if (error == "") {
      final user = AuthRecords.instance.getUser();
      if (user != null) yield LoginStateSuccessful(user: user);
      else yield LoginStateIdle(error: error);
    }
    else yield LoginStateIdle(error: error);
  }

  Stream<LoginState> _mapIdleToState() async* {
    final user = AuthRecords.instance.getUser();
    if (user != null) yield LoginStateSuccessful(user: user);
    else yield LoginStateIdle();
  }

  Stream<LoginState> _mapCloseSessionToState() async* {
    yield LoginStateLoading();
    final error = await AuthRecords.instance.closeSession();
    if (error == 0) yield LoginStateLoggedOut(message: "Successfully closed your session. "
        "You may now close this page.");
    else {
      final user = AuthRecords.instance.getUser();
      if (user != null) yield LoginStateSuccessful(user: user);
      else yield LoginStateIdle(error: "Unknown error while closing session");
    }
  }

  Stream<LoginState> _mapRemoveAccountToState(RemoveAccount event) async* {
    yield LoginStateLoading();
    final error = await AuthRecords.instance.deleteAccount(event.password);
    if (error == "") yield LoginStateLoggedOut(message: "Successfully removed your account "
        "and all of your data in the server. You may now close this page.");
    else {
      final user = AuthRecords.instance.getUser();
      if (user != null) yield LoginStateSuccessful(user: user);
      else yield LoginStateIdle(error: "Unknown error while removing account");
    }
  }

  Stream<LoginState> _mapChangePasswordToState(ChangePassword event) async* {
    yield LoginStateLoading();
    final error = await AuthRecords.instance.changePassword(event.oldPassword, event.newPassword);
    if (error == "") {
      final user = AuthRecords.instance.getUser();
      if (user != null) yield LoginStateSuccessful(user: user);
      else yield LoginStateIdle(error: error);
    }
    else yield LoginStateIdle(error: error);
  }
}