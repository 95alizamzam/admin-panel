

import 'package:bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/admin_bloc/admin_events.dart';
import 'package:marketing_admin_panel/bloc/admin_bloc/admin_states.dart';
import 'package:marketing_admin_panel/repositories/admin/admin_repo.dart';

import '../../locator.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminStateInitialized()) {
    on<AdminEvent>((event, emit) async {
      if (event is SignInAdmin) {
        emit(AdminSignInLoading());
        try {
          await locator.get<AdminRepo>().signInAdmin(event.email, event.password);
          emit(AdminSignInSuccess());
        } catch (e) {
          String message = 'Log In Failed';
          switch(e){
            case 'not admin': message = 'You don\'t have permission '; break;
            case 'user-disabled': message = 'User disabled'; break;
            case 'invalid-email': message = 'Invalid email'; break;
            case 'user-not-found': message = 'User not found'; break;
            case 'wrong-password': message = 'Password wrong'; break;
            case 'network-request-failed': message = 'Network error'; break;
          }
          emit(AdminSignInFailed(message));
        }
      }
    });
  }
}
