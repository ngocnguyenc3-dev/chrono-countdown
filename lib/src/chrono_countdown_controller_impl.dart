import 'dart:async';

import 'chrono_countdown_controller.dart';

class ChronoCountdownControllerImpl extends ChronoCountdownController {
  ChronoCountdownControllerImpl({required Duration initDuration})
      : _seconds = initDuration.inSeconds {
    resume();
  }

  int _seconds;
  Timer? _timer;

  
  @override
  bool get isFinished => _seconds == 0;
  
  @override
  bool get isPaused => _timer == null;
  
  @override
  void pause() {
    _disposeTimer();
  }
  
  @override
  void resume() {
    pause();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _disposeTimer();
        return;
      }
      _seconds--;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _disposeTimer();
    super.dispose();
  }

  void _disposeTimer() {
    _timer?.cancel();
    _timer = null;
  }
  
  @override
  get value => _seconds;
}
