import 'package:bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/events.dart';
import 'package:marketing_admin_panel/bloc/states.dart';

class PanelBloc extends Bloc<PanelEvents, PanelStates> {
  PanelBloc() : super(PanelInitialStates()) {
    on<PanelEvents>((event, emit) {
      if (event is ChangeIndexEvents) {
        emit(PanelChangeBodyDoneState(event.index));
      }
    });
  }
}
