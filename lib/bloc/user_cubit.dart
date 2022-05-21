import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/services/auth_service.dart';
import 'package:geeksday/ui/guategeeks/multiavatar.dart';
import 'package:quiver/iterables.dart';

class UserCubit extends Cubit<UserState> {
  final AuthServiceBase _authService;
  UserCubit(AuthUser user, this._authService) : super(UserInitialState(user));

  get isEditing => state is UserEditingState;

  void updateUser() {
    state.user.image = state.partDescriptor?.values
        .reduce((value, element) => "$value$element");
    _authService.updateUser(state.user).then((value) {
      emit(UserUpdatedState(state.user));
    });
  }

  void cancelEditing() {
    emit(UserInitialState(state.user));
  }

  void userEditing() {
    emit(UserEditingState(state.user, getPartDescriptor()));
  }

  Map<MultiAvatarPart, dynamic> getPartDescriptor() {
    return state.partDescriptor ??
        {
          MultiAvatarPart.env: "00",
          MultiAvatarPart.clo: "00",
          MultiAvatarPart.head: "00",
          MultiAvatarPart.mouth: "00",
          MultiAvatarPart.eyes: "00",
          MultiAvatarPart.top: "00",
        };
  }

  void updatePartDescriptor(Map<MultiAvatarPart, dynamic> partDescriptor) {
    emit(UserEditingState(state.user, partDescriptor));
  }

  String getUserName() {
    return state.user.name;
  }

  void updateName(String text) {
    state.user.name = text;
  }
}

abstract class UserState {
  final AuthUser user;
  Map<MultiAvatarPart, dynamic>? partDescriptor;
  UserState(this.user, {this.partDescriptor}) {
    if (user.image.length == 12 && partDescriptor == null) {
      var pairs =
          partition(user.image.split(""), 2).map((e) => "${e[0]}${e[1]}");
      partDescriptor = pairs.toList().asMap().map((index, value) {
        return MapEntry(MultiAvatarPart.values[index], value);
      });
    }
  }
}

class UserInitialState extends UserState {
  UserInitialState(super.user);
}

class UserEditingState extends UserState {
  UserEditingState(user, partDescriptor)
      : super(user, partDescriptor: partDescriptor);
}

class UserUpdatedState extends UserState {
  UserUpdatedState(super.user);
}
