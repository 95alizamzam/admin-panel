import 'package:bloc/bloc.dart';

import 'events.dart';
import 'states.dart';

class PanelBloc extends Bloc<PanelEvents, PanelStates> {
  PanelBloc() : super(PanelInitialStates()) {
    on<PanelEvents>((event, emit) {
      if (event is ChangeIndexEvents) {
        emit(PanelChangeBodyDoneState(event.index));
      }
    });
  }
}
