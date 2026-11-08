import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Environment { development, production }

class AppConfig {
  const AppConfig._({
    required this.env,
    required this.baseUrl,
    required this.appName,
  });

  final Environment env;
  final String baseUrl;
  final String appName;

  bool get isProduction => env == Environment.production;

  static const _envName = String.fromEnvironment('ENV');

  static late final AppConfig instance;

  static Future<void> load() async {
    // Throws if ENV is missing or misspelled, so there is no silent default.
    final env = Environment.values.byName(_envName);

    final file = switch (env) {
      Environment.development => 'assets/env/.env.dev',
      Environment.production => 'assets/env/.env.prod',
    };

    await dotenv.load(fileName: file);

    instance = AppConfig._(
      env: env,
      baseUrl: dotenv.get('BASE_URL'), // throws if the key is missing
      appName: dotenv.get('APP_NAME', fallback: 'Taskly'),
    );
  }
}
