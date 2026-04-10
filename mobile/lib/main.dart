import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nomnom_mobile/app.dart';
import 'package:nomnom_mobile/core/logging/app_talker.dart';
import 'package:nomnom_mobile/di/di.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      appTalker.handle(details.exception, details.stack);
    };

    await configureDependencies();

    runApp(NomNomApp());
  }, (error, stackTrace) {
    appTalker.handle(error, stackTrace);
  });
}
