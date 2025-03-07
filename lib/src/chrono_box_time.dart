  import 'dart:math';

  import 'package:flutter/material.dart';

  import '../chrono_countdown.dart';
  import 'digit_animated.dart';

  class ChronoBoxTime extends StatefulWidget {
    const ChronoBoxTime({
      super.key,
      required this.controller,
      required this.caculateTime,
      this.style,
      this.direction = ChronoDirection.bottomToTop,
    });

    final TextStyle? style;
    final int Function(int) caculateTime;
    final ChronoDirection direction;
    final ChronoCountdownController controller;

    @override
    State<ChronoBoxTime> createState() => _ChronoBoxTimeState();
  }

  class _ChronoBoxTimeState extends State<ChronoBoxTime> {
    int initLength = 2;

    @override
    void initState() {
      super.initState();
      initLength = max(2, widget.caculateTime(widget.controller.value).toString().length);
    }

    @override
    Widget build(BuildContext context) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List.generate(initLength, (index) => index).map(
            (e) {
              return ValueListenableBuilder(
                  valueListenable: widget.controller,
                  builder: (context, value, child) {
                    return DigitAnimated(
                      value: getListDigit(widget.caculateTime(value))[e],
                      style: widget.style,
                      direction: widget.direction,
                    );
                  });
            },
          )
        ],
      );
    }

    List<String> getListDigit(int time) {
      var result = time.toString().split('');

      if (result.length != initLength) {
        result = [
          ...List.filled(max(0, initLength - result.length), '0'),
          ...result
        ];
      }
      return result;
    }
  }
