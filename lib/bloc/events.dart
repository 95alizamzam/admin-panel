abstract class PanelEvents {}

class ChangeIndexEvents extends PanelEvents {
  final int index;
  ChangeIndexEvents(this.index);
}
