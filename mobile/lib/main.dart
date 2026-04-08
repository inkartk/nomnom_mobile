import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomnom_mobile/app.dart';
import 'package:nomnom_mobile/core/logging/app_talker.dart';
import 'package:nomnom_mobile/di/di.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      appTalker.handle(details.exception, details.stack);
    };

    Bloc.observer = TalkerBlocObserver(talker: appTalker);

    await configureDependencies();

    runApp(NomNomApp());
  }, (error, stackTrace) {
    appTalker.handle(error, stackTrace);
  });
}
