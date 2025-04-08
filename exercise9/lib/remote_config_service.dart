import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(seconds: 10),
    ));

    await _remoteConfig.fetchAndActivate();
    print("✅ Remote Config fetched:");
    print("  title: ${_remoteConfig.getString('notification_title')}");
    print("  message: ${_remoteConfig.getString('notification_message')}");
  }

  int get notificationInterval =>
      _remoteConfig.getInt('periodic_local_notification');

  String get notificationTitle =>
      _remoteConfig.getString('notification_title');

  String get notificationMessage =>
      _remoteConfig.getString('notification_message');
}
