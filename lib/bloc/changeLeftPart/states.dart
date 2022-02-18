abstract class PanelStates {}

class PanelInitialStates extends PanelStates {}

class PanelChangeBodyDoneState extends PanelStates {
  final int selectedIndex;
  PanelChangeBodyDoneState(this.selectedIndex);
}
