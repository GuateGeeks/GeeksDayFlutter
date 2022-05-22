import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/services/auth_service.dart';
import 'package:geeksday/ui/guategeeks/multiavatar.dart';
import 'package:quiver/iterables.dart';

class UserCubit extends Cubit<UserState> {
  final AuthServiceBase _authService;
  AuthUser _originalUser;
  UserCubit(this._originalUser, this._authService)
      : super(UserInitialState(_originalUser));

  get isEditing => state is UserEditingState;

  void updateUser() {
    state.user.image = state.image!;
    _authService.updateUser(state.user).then((value) {
      emit(UserUpdatedState(state.user));
    });
  }

  void cancelEditing() {
    emit(UserCancelEditingState(_originalUser));
  }

  void userEditing() {
    emit(UserEditingState(state.user, state.image));
  }

  String getUserName() {
    return state.name!;
  }

  void updateName(String text) {
    state.name = text;
  }

  void updateImage(String image) {
    state.image = image;
    emit(UserEditingState(state.user, state.image));
  }

  void randomAvatar() {
    var random = List.generate(
        6, (_) => Random().nextInt(47).toString().padLeft(2, '0'));
    emit(UserEditingState(state.user, random.join()));
  }

  void setUser(AuthUser userData) {
    emit(UserInitialState(userData));
  }

  String getImage() {
    return state.image!;
  }
}

abstract class UserState {
  AuthUser user;
  String? name;
  String? image;
  UserState(this.user, {this.image}) {
    name = user.name;
    image ??= user.image;
  }
}

class UserInitialState extends UserState {
  UserInitialState(super.user);
}

class UserCancelEditingState extends UserState {
  UserCancelEditingState(super.user);
}

class UserEditingState extends UserState {
  UserEditingState(user, image) : super(user, image: image);
}

class UserUpdatedState extends UserState {
  UserUpdatedState(super.user);
}
