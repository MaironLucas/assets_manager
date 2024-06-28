import 'package:assets_manager/common/di.dart';
import 'package:assets_manager/common/routing/routing.dart';
import 'package:assets_manager/common/theme.dart';
import 'package:assets_manager/common/util.dart';
import 'package:assets_manager/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'Assets Manager',
      theme: theme.light(),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      routerConfig: appRoutes,
    );
  }
}
