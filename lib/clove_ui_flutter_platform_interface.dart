import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'clove_ui_flutter_method_channel.dart';

abstract class CloveUiFlutterPlatform extends PlatformInterface {
  /// Constructs a CloveUiFlutterPlatform.
  CloveUiFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static CloveUiFlutterPlatform _instance = MethodChannelCloveUiFlutter();

  /// The default instance of [CloveUiFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelCloveUiFlutter].
  static CloveUiFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CloveUiFlutterPlatform] when
  /// they register themselves.
  static set instance(CloveUiFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
