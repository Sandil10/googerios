/// Central API configuration.
///
/// Mirrors the web app's `services/apiConfig.ts`: production talks to the
/// backend through `https://googer.site/api`. Override with --dart-define=API_URL=...
class ApiConfig {
  ApiConfig._();

  /// Base URL for all API calls. The backend is exposed at `googer.site/api`.
  static const String baseUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'https://googer.site/api',
  );
}
