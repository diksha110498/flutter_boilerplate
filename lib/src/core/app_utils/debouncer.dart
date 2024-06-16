import 'dart:async';
import 'dart:ui';

class Debouncer {
  final int ?milliseconds;
  VoidCallback ?action;
  Timer ?_timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds??1000), action);
  }

  cancel()
  {
    _timer?.cancel();
    _timer=null;
  }
}