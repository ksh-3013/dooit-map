import 'dart:async';

import 'package:flutter/material.dart';

class CheckProvider extends ChangeNotifier {
  late Timer _ticker;
  Duration _elapsed = Duration.zero;
  bool _running = false;

  Duration get elapsed => _elapsed;

  bool get isRunning => _running;

  void start() {
    if (_running) return;
    _running = true;
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      _elapsed += const Duration(seconds: 1);
      notifyListeners();
    });
    notifyListeners();
  }

  void stop() {
    if (!_running) return;
    _running = false;
    _ticker.cancel();
    notifyListeners();
  }

  void reset() {
    _ticker.cancel();
    _running = false;
    _elapsed = Duration.zero;
    notifyListeners();
  }

  void toggle() => _running ? stop() : start();

  @override
  void dispose() {
    if (_running) _ticker.cancel();
    super.dispose();
  }

  String get formatted {
    final h = _elapsed.inHours.toString().padLeft(2, '0');
    final m = (_elapsed.inMinutes % 60).toString().padLeft(2, '0');
    final s = (_elapsed.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }
}
