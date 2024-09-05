import 'package:flutter_test/flutter_test.dart';
import 'package:clove_ui_flutter/clove_ui_flutter.dart';
import 'package:clove_ui_flutter/clove_ui_flutter_platform_interface.dart';
import 'package:clove_ui_flutter/clove_ui_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCloveUiFlutterPlatform
    with MockPlatformInterfaceMixin
    implements CloveUiFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CloveUiFlutterPlatform initialPlatform = CloveUiFlutterPlatform.instance;

  test('$MethodChannelCloveUiFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCloveUiFlutter>());
  });

  test('getPlatformVersion', () async {
    CloveUiFlutter cloveUiFlutterPlugin = CloveUiFlutter();
    MockCloveUiFlutterPlatform fakePlatform = MockCloveUiFlutterPlatform();
    CloveUiFlutterPlatform.instance = fakePlatform;

    expect(await cloveUiFlutterPlugin.getPlatformVersion(), '42');
  });
}
