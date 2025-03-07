# Chrono Countdown
A customizable time countdown widget for Flutter applications.

## Features

- 🎯 Simple and easy to use countdown timer widget
- 🎨 Highly customizable appearance
- ⚡ Lightweight and performant

## Getting Started

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  chrono_countdown: ^0.0.1
```

## Usage

```dart
import 'package:chrono_countdown/chrono_countdown.dart';

ChronoCountdownWidget(
    initDuration: const Duration(
        days: 0,
        hours: 99,
        minutes: 0,
        seconds: 5,
    ),
    boxTimeBuilder: (child) => Container(
        height: 40,
        constraints: const BoxConstraints(minWidth: 40),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8),
        ),
        child: child,
    ),
    separatorBuilder: () => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: Text(
            ':',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
            ),
        ),
    ),
)
