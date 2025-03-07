import 'package:flutter/foundation.dart';

import 'chrono_countdown_controller_impl.dart';

/// [ChronoCountdownController] is a controller for [ChronoCountdownWidget].
///
/// It is used to control the countdown timer and the state of the countdown.
///
/// [isPaused] is true if the countdown is paused.
///
/// [isFinished] is true if the countdown is finished.
///

abstract class ChronoCountdownController extends ValueListenable
    with ChangeNotifier {
  ChronoCountdownController();

  bool get isPaused;
  bool get isFinished;

  void pause();
  void resume();

  factory ChronoCountdownController.fromDuration(
          {required Duration initDuration}) =>
      ChronoCountdownControllerImpl(initDuration: initDuration);
}
