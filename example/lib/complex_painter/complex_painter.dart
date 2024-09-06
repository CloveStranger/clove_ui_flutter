import 'package:clove_ui_flutter/clove_ui_flutter.dart';
import 'package:flutter/material.dart';

class ComplexPainterExample extends StatelessWidget {
  const ComplexPainterExample({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Complex Painter',
        ),
      ),
      body: ComplexPainter(
        controller: ComplexPainterController(),
      ),
    );
  }
}
