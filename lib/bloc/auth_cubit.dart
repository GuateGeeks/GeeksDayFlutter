import 'dart:async';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/services/auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthServiceBase _authService;
  late StreamSubscription _authSubscription;

  AuthCubit(this._authService) : super(AuthInitialState());

  Future<void> init() async {
    // Just for testing. Allows the splash screen to be shown a few seconds
    await Future.delayed(Duration(seconds: 3));
    _authSubscription =
        _authService.onAuthStateChanged.listen(_authStateChanged);
  }

  Future<void> reset() async => emit(AuthInitialState());

  void _authStateChanged(AuthUser? user) =>
      user == null ? emit(AuthSignedOut()) : emit(AuthSignedIn(user));

  Future<void> createUserWithEmailAndPassword(
          String email, String username, String password) =>
      _signIn(_authService.createUserWithEmailAndPassword(
          email, username, password));

  Future<void> signInWithEmailAndPassword(String email, String password) =>
      _signIn(_authService.signInWithEmailAndPassword(email, password));

  Future<void> signInAnonymously() => _signIn(_authService.signInAnonymously());

  Future<void> signInWithGoogle() => _signIn(_authService.signInWithGoogle());

  Future<void> signInWithFacebook() =>
      _signIn(_authService.signInWithFacebook());

  Future<void> _signIn(Future<AuthUser?> auxUser) async {
    try {
      emit(AuthSigningIn());
      final user = await auxUser;
      if (user == null) {
        emit(AuthError("Unknown error, try again later"));
      } else {
        emit(AuthSignedIn(user));
      }
    } catch (e) {
      emit(AuthError("Error ${e.toString()}"));
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    emit(AuthSignedOut());
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }

  String getUserId() {
    if (state is AuthSignedIn) {
      return (state as AuthSignedIn).user.uid;
    }
    return "NO USER";
  }
}

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthSignedOut extends AuthState {}

class AuthSigningIn extends AuthState {}

class AuthSignedIn extends AuthState {
  final AuthUser user;

  AuthSignedIn(this.user);

  @override
  List<Object?> get props => [user];
}
