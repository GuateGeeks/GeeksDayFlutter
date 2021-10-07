

import 'package:geeksday/models/auth_user.dart';

abstract class AdminServiceBase{
  Future<List<AuthUser>> higherScoreUserList();
}