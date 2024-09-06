import 'package:clove_ui_flutter/clove_ui_flutter.dart';
import 'package:clove_ui_flutter/src/elements/complex_painter/controller/matrix_controller.dart';
import 'package:flutter/material.dart';

double _kDrag = 1e-200;

class ComplexPainterMatrixWrapper extends StatelessWidget {
  final ComplexPainterController controller;
  final Widget child;

  const ComplexPainterMatrixWrapper({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final MatrixController matrixController = controller.matrixController;
    return InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(double.infinity),
      minScale: 0.5,
      maxScale: 5,
      interactionEndFrictionCoefficient: _kDrag,
      scaleEnabled: true,
      panEnabled: true,
      transformationController: matrixController.transformationController,
      onInteractionStart: controller.onScaleStart,
      onInteractionUpdate: controller.onScaleUpdate,
      onInteractionEnd: controller.onScaleEnd,
      child: child,
    );
  }
}
