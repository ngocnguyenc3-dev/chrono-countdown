import 'package:flutter/material.dart';

import 'chrono_box_time.dart';
import 'chrono_countdown_controller.dart';


class ChronoCountdownWidget extends StatefulWidget {
  /// You can use initDuration or controller to initialize the countdown.
  /// But you cannot use both.
  const ChronoCountdownWidget({
    super.key,
    this.initDuration,
    this.controller,
    this.direction = ChronoDirection.bottomToTop,
    required this.boxTimeBuilder,
    this.separatorBuilder,
    this.chronoTimeType = ChronoTimeType.hours,
    this.textStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  }) : assert(
            (initDuration != null) ^ (controller != null),
            'initDuration and controller cannot both be provided');

  /// The initial duration of the countdown.
  final Duration? initDuration;

  /// The style of the text.
  final TextStyle textStyle;

  /// The direction of the countdown.
  final ChronoDirection direction;

  /// The separator builder.
  final Function()? separatorBuilder;

  /// The box time builder.
  final Function(ChronoBoxTime child)? boxTimeBuilder;

  final ChronoTimeType chronoTimeType;

  /// The controller.
  final ChronoCountdownController? controller;

  @override
  State<ChronoCountdownWidget> createState() => _ChronoCountdownWidgetState();
}

class _ChronoCountdownWidgetState extends State<ChronoCountdownWidget> {
  static const _secondsInMinute = 60;
  static const _secondsInHour = 60 * _secondsInMinute;
  static const _secondsInDay = 24 * _secondsInHour;
  late final ChronoCountdownController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ??
        ChronoCountdownController.fromDuration(
            initDuration: widget.initDuration!);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.chronoTimeType.isShowDays) ...[
          widget.boxTimeBuilder?.call(ChronoBoxTime(
            controller: controller,
            caculateTime: getDayTime,
            style: widget.textStyle,
            direction: widget.direction,
          )),
          widget.separatorBuilder?.call(),
        ],
        if (widget.chronoTimeType.isShowHours) ...[
          widget.boxTimeBuilder?.call(ChronoBoxTime(
            controller: controller,
            caculateTime: getHourTime,
            style: widget.textStyle,
            direction: widget.direction,
          )),
          widget.separatorBuilder?.call(),
        ],
        if (widget.chronoTimeType.isShowMinutes) ...[
          widget.boxTimeBuilder?.call(ChronoBoxTime(
            controller: controller,
            caculateTime: getMinuteTime,
            style: widget.textStyle,
            direction: widget.direction,
          )),
          widget.separatorBuilder?.call(),
        ],
        widget.boxTimeBuilder?.call(ChronoBoxTime(
          controller: controller,
          caculateTime: getSecondTime,
          style: widget.textStyle,
          direction: widget.direction,
        )),
      ],
    );
  }

  int getSecondTime(totalSecond) {
    if (widget.chronoTimeType.isSeconds) {
      return totalSecond;
    }

    return totalSecond % _secondsInMinute;
  }

  int getMinuteTime(int totalSecond) {
    if (widget.chronoTimeType.isSeconds) {
      return 0;
    }

    if (widget.chronoTimeType.isMinutes) {
      return totalSecond ~/ _secondsInMinute;
    }

    return (totalSecond % _secondsInHour) ~/ _secondsInMinute;
  }

  int getHourTime(totalSecond) {
    if (widget.chronoTimeType.isSeconds || widget.chronoTimeType.isMinutes) {
      return 0;
    }

    if (widget.chronoTimeType.isHours) {
      return totalSecond ~/ _secondsInHour;
    }

    return (totalSecond % _secondsInDay) ~/ _secondsInHour;
  }

  int getDayTime(value) {
    return value ~/ _secondsInDay;
  }
}

enum ChronoDirection {
  bottomToTop,
  topToBottom,
}

enum ChronoTimeType {
  days,
  hours,
  minutes,
  seconds,
}

extension ChronoTimeTypeX on ChronoTimeType {
  bool get isShowDays => this == ChronoTimeType.days;
  bool get isShowHours => isShowDays || this == ChronoTimeType.hours;
  bool get isShowMinutes => this != ChronoTimeType.seconds;

  bool get isSeconds => this == ChronoTimeType.seconds;
  bool get isMinutes => this == ChronoTimeType.minutes;
  bool get isHours => this == ChronoTimeType.hours;
  bool get isDays => this == ChronoTimeType.days;
}

extension ChronoDirectionX on ChronoDirection {
  bool get isBottomToTop => this == ChronoDirection.bottomToTop;
  bool get isTopToBottom => this == ChronoDirection.topToBottom;
}
