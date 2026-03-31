import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app.dart';
import 'core/models/deed.dart';
import 'core/models/deed_category.dart';
import 'core/models/session.dart';
import 'core/models/settings_model.dart';
import 'core/services/notification_service.dart';
import 'core/services/screen_time_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF0D1F1A),
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Hive.initFlutter();
  Hive.registerAdapter(DeedCategoryAdapter());
  Hive.registerAdapter(DeedAdapter());
  Hive.registerAdapter(SessionAdapter());
  Hive.registerAdapter(SettingsModelAdapter());

  await NotificationService().initialize();
  await ScreenTimeService().initialize();

  runApp(
    const ProviderScope(
      child: NafsGuardApp(),
    ),
  );
}
