import 'dart:async';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/services/auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthCubit extends Cubit<AuthState> {
  final AuthServiceBase _authService;
  late StreamSubscription _authSubscription;

  AuthCubit(this._authService) : super(AuthInitialState()){
    getUsersList();
  }

  List<AuthUser> _list = [];
  AuthUser? user;

  Future<void> init() async {
    // Just for testing. Allows the splash screen to be shown a few seconds
    await Future.delayed(Duration(seconds: 1));
    _authSubscription =
        _authService.onAuthStateChanged.listen(_authStateChanged);
  }

  Future<void> reset() async => emit(AuthInitialState());

  void _authStateChanged(AuthUser? user) =>
      user == null ? emit(AuthSignedOut()) : emit(AuthSignedIn(user));

  Future<void> createUserWithEmailAndPassword(
          String email, String username, String password, String image) =>
      _signIn(_authService.createUserWithEmailAndPassword(
          email, username, password, image));

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
      print(e);
      switch (e.toString()) {
        case "[firebase_auth/invalid-email] The email address is badly formatted.":
          emit(AuthError("*El correo ingresado no es válido"));
          break;
        case "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.":
          emit(AuthError("*El correo o contraseña es incorrecta"));
          break;
        case "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.":
          emit(AuthError("*El correo o contraseña es incorrecta"));
          break;
        case "[firebase_auth/email-already-in-use] The email address is already in use by another account.":
          emit(AuthError("*El correo ya está en uso"));
          break;
        default:
          emit(AuthError("*Ocurrió un probleme, por favor inténtelo más tarde"));
          break;
      }
    }
  }

  Future<void> getUsersList() async {
    List<AuthUser> users = [];
    _list = await _authService.getUsersList();
    _list.forEach((user) { 
      users.add(user);
    });
  }

  AuthUser getUserByPost(String userId){
    var user;
    _list.forEach((element) {
      if(element.uid == userId){
        user = element;
      }
    });
    return user;
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

  AuthUser getUser() {
    return (state as AuthSignedIn).user;
  }

  String getUserImage() {
    return (state as AuthSignedIn).user.image;
  }

  String getUserId() {
    if (state is AuthSignedIn) {
      return (state as AuthSignedIn).user.uid;
    }
    return "NO USER";
  }

  //Edit User Profile
  void updateUser(userName, avatar) {
    getUsersList();
    AuthUser user =
        (state as AuthSignedIn).user.copyWith(name: userName, image: avatar);
    _authService.updateUser(user).then((value) {
      emit(AuthSignedIn(user));

    });
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
