import 'package:flutter/material.dart';
import 'package:rctv/providers/reactive_provider.dart';
import 'app_theme.dart';
import 'providers/global_error_widget.dart';
import 'providers/auth_widget.dart';
import 'providers/notifications_service_widget.dart';
import 'routes.dart';
import 'service_locator.dart';

var appTheme = AppTheme();

class App extends StatelessWidget {

  final GlobalAppThemeConfig globalAppThemeConfig = sl();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return ReactiveProvider(
      globalAppThemeConfig.themeMode,
      builder: (context, themeMode, _) => MaterialApp.router(
        routerConfig: mainRouter,
        theme: appTheme.light,
        darkTheme: appTheme.dark,
        themeMode: themeMode,
        builder: (context, child) {
          return NotificationsServiceWidget(
            child: GlobalErrorWidget(
              child: {{#useFirebase}}GlobalAuthWidget(
                navigatorKey: mainRouter.routerDelegate.navigatorKey,
                child: child ?? const SizedBox(),
              ),{{/useFirebase}}{{^useFirebase}}child ?? const SizedBox(){{/useFirebase}}
            ),
          );
        },
      ),
    );
  }
}