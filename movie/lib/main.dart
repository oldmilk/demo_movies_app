import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie/app/configs/app_theme.dart';
import 'package:movie/app/constants/app_strings.dart';
import 'package:movie/app/entities/media.dart';
import 'package:movie/app/entities/recent.dart';
import 'package:movie/app/routes/app_router.dart';
import 'package:movie/app/services/service_locator.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MediaAdapter());
  Hive.registerAdapter(RecentAdapter());
  await Hive.openBox('recents');
  ServiceLocator.init();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      theme: getApplicationTheme(),
      routerConfig: AppRouter().router,
    );
  }
}
