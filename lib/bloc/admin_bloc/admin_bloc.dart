

import 'package:bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/admin_bloc/admin_events.dart';
import 'package:marketing_admin_panel/bloc/admin_bloc/admin_states.dart';
import 'package:marketing_admin_panel/repositories/admin/admin_repo.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminRepo _adminRepo = AdminRepo();

  AdminBloc() : super(AdminStateInitialized()) {
    on<AdminEvent>((event, emit) async {
      if (event is SignInAdmin) {
        emit(AdminSignInLoading());
        try {
         await _adminRepo.signInAdmin(event.email, event.password);
        } catch (e) {
          emit(AdminSignInFailed('Sign In Failed'));
        }
      }
    });
  }
}
