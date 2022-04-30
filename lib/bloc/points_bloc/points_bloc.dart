import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/bloc/points_bloc/points_events.dart';
import 'package:marketing_admin_panel/bloc/points_bloc/points_states.dart';
import 'package:marketing_admin_panel/models/usersModel.dart';
import 'package:marketing_admin_panel/repositories/users/user_repo.dart';

import '../../locator.dart';

class PointsBloc extends Bloc<PointsEvent, PointsState> {

  PointsBloc() : super(PointsInitialState()) {
    on<PointsEvent>((event, emit) async {
      if(event is SendPoints){
        emit(SendPointsLoading());
        try {
          OneUserModel oneUserModel = await locator.get<UserRepo>().getUserById(event.userId);
          if (oneUserModel.id == null)
            emit(SendPointsFailed('User Not Found'));
          else {
            await locator.get<UserRepo>().sendPointsToUser(event.userId, event.amount);
            HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('sendPointsNotification');
            String senderName = 'OVX Style App';
            await callable.call(<String, dynamic>{
              'userId': event.userId,
              'senderName': senderName,
              'pointsAmount': event.amount,
            });
            emit(SendPointsSucceed());
          }
        }catch(e){
          emit(SendPointsFailed('Error Occurred'));
        }
      }
    });
  }
}
