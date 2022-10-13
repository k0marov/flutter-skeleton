import 'package:http/http.dart' as http;
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

import 'config/const.dart';
import 'logic/core/auth/auth_facade.dart';
import 'logic/core/auth/auth_http_client.dart';
import 'logic/core/entity/network_crud.dart';
import 'logic/core/entity/network_use_case_factory.dart';
import 'logic/core/theme_brightness/get_theme_brightness_stream_usecase.dart';
import 'logic/core/theme_brightness/toggle_theme_brightness_usecase.dart';

class UIDeps {
  final GetThemeBrightnessStreamUseCase getBrightnessStream;
  final ToggleThemeBrightnessUseCase toggleBrightness;
  final AuthFacade auth;

  const UIDeps._(
    this.getBrightnessStream,
    this.toggleBrightness,
    this.auth,
  );
}

late final UIDeps uiDeps;

Future<void> initialize() async {
  final authFacade = AuthFacadeImpl();
  final httpClient = AuthHTTPClient(authFacade, http.Client());
  final nucFactory = NetworkUseCaseFactory(apiHost, httpClient);

  final sharedPrefs = RxSharedPreferences.getInstance();
  final toggleTheme = newToggleThemeBrightnessUseCase(sharedPrefs);
  final getThemeStream = newGetThemeBrightnessUseCase(sharedPrefs);

  final networkCrud = NetworkCRUD(nucFactory);

  uiDeps = UIDeps._(
    getThemeStream,
    toggleTheme,
    authFacade,
  );
}
