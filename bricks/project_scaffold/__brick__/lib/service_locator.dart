{{#useFirebase}}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
{{/useFirebase}}
import 'package:get_it/get_it.dart';
import 'package:rctv/rctv.dart';
import 'app_theme.dart';
import 'model/error_handlers/error_service_plugins/api_error_plugin.dart';
import 'model/services/auth_service.dart';
import 'model/services/error_service.dart';
import 'model/services/media_service.dart';
import 'model/services/navigation_chain_service.dart';
import 'model/services/notification_service.dart';
{{#useFirebase}}
import 'model/error_handlers/error_service_plugins/firebase_auth_error_plugin.dart';
{{/useFirebase}}
import 'model/error_handlers/error_service_plugins/info_exception_plugin.dart';
import 'model/services/preferences_service.dart';

final sl = GetIt.instance;

void initLocator() {

  //Error service
  final ErrorService errorService = ErrorService();
  errorService.registerPlugins([
    apiErrorPlugin,
    infoExceptionPlugin,
    {{#useFirebase}}firebaseAuthErrorPlugin{{/useFirebase}}
  ]);
  sl.registerSingleton(errorService);

  //Set up Loadable errors
  Loadable.defaultErrorHandler = errorService.receiveError;

  {{#useFirebase}}
  sl.registerLazySingleton(() => FirebaseStorage.instance);
  {{/useFirebase}}

  {{#useFirebase}}
  sl.registerLazySingleton(() => AuthService(FirebaseAuth.instance));
  {{/useFirebase}}

  sl.registerLazySingleton(() => NotificationService());
  sl.registerLazySingleton(() => MediaService());
  sl.registerLazySingleton(() => PreferencesService());
  sl.registerLazySingleton(() => NavigationChainService());
  sl.registerLazySingleton(() => GlobalAppThemeConfig());

}