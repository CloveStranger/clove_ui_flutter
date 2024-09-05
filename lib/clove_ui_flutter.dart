library clove_ui_flutter;

import 'clove_ui_flutter_platform_interface.dart';

export 'src/elements/complex_painter/complex_painter.dart';

class CloveUiFlutter {
  Future<String?> getPlatformVersion() {
    return CloveUiFlutterPlatform.instance.getPlatformVersion();
  }
}
