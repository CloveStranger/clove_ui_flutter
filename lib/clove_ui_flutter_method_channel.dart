import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'clove_ui_flutter_platform_interface.dart';

/// An implementation of [CloveUiFlutterPlatform] that uses method channels.
class MethodChannelCloveUiFlutter extends CloveUiFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('clove_ui_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
