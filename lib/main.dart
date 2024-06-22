import 'package:assets_manager/common/di.dart';
import 'package:assets_manager/common/routing/routing.dart';
import 'package:assets_manager/common/theme.dart';
import 'package:assets_manager/common/util.dart';
import 'package:flutter/material.dart';

void main() {
  setupDI();
  runApp(
    const _MyApp(),
  );
}

class _MyApp extends StatelessWidget {
  const _MyApp();

  @override
  Widget build(BuildContext context) {
    final textTheme = createTextTheme(context, "Poppins", "Poppins");
    final theme = MaterialTheme(textTheme);
    return MaterialApp.router(
      title: 'Assets Manager',
      theme: theme.light(),
      routerConfig: appRoutes,
    );
  }
}
