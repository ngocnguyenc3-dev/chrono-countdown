import 'package:flutter/material.dart';

import '../chrono_countdown.dart';

class DigitAnimated extends StatefulWidget {
  const DigitAnimated({
    super.key,
    required this.value,
    this.style,
    this.direction = ChronoDirection.bottomToTop,
  });

  final String value;
  final TextStyle? style;
  final ChronoDirection direction;
  @override
  State<DigitAnimated> createState() => _DigitAnimatedState();
}

class _DigitAnimatedState extends State<DigitAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late String oldValue = widget.value;
  late String newValue = widget.value;
  late Animation<Offset> firstDigitAnim;
  late Animation<Offset> secondDigitAnim;

  static const Offset topOffset = Offset(0, -1);
  static const Offset bottomOffset = Offset(0, 1);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    firstDigitAnim = Tween<Offset>(
      begin: widget.direction.isBottomToTop ? bottomOffset : topOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    secondDigitAnim = Tween<Offset>(
      begin: Offset.zero,
      end: widget.direction.isBottomToTop ? topOffset : bottomOffset,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DigitAnimated oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldValue = oldWidget.value;
    newValue = widget.value;
    if (oldValue == newValue) {
      return;
    }
    _controller
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) => ClipRRect(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text('0', style: widget.style?.apply(color: Colors.transparent)),
            SlideTransition(
                position: firstDigitAnim,
                child: Text(
                  newValue,
                  style: widget.style,
                )),
            SlideTransition(
                position: secondDigitAnim,
                child: Text(oldValue, style: widget.style)),
          ],
        ),
      );
}
