import 'package:clove_ui_flutter/src/elements/complex_painter/complex_painter_controller.dart';
import 'package:clove_ui_flutter/src/elements/complex_painter/layer/layer.dart';
import 'package:clove_ui_flutter/src/elements/complex_painter/wrapper/matrix.dart';
import 'package:flutter/material.dart';

export 'complex_painter_controller.dart';

class ComplexPainter extends StatelessWidget {
  final ComplexPainterController controller;

  const ComplexPainter({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
      ),
      child: SizedBox.expand(
        child: ComplexPainterMatrixWrapper(
          controller: controller,
          child: Stack(
            children: [
              ComplexPainterLayer(
                isForeLayers: false,
                controller: controller,
              ),
              Positioned.fill(
                child: Image.network(
                  'https://dc-ai-storage.oss-us-east-1.aliyuncs.com/system_data/upload/Nanoid_Y1jIp58igNzfMRZegcTtP_16.png',
                ),
              ),
              ComplexPainterLayer(
                isForeLayers: false,
                controller: controller,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
