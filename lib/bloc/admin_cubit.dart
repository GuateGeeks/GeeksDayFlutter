
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/services/admin_service.dart';

class AdminCubit extends Cubit<AdminState>{
  final AdminServiceBase _adminService;
  AdminCubit(this._adminService) : super(InitialAdminState());

    String dataUserformAdmin(categorie){
    if(categorie == 1){
      return "Categoria seleccionada es 1";
    }else{
      return "Esa categoria no existe";
    }
  }

  Future<List> userList(){
    return _adminService.higherScoreUserList();
  }



  
}


abstract class AdminState{

}

class InitialAdminState extends AdminState{

}