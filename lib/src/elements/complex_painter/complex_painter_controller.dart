import 'package:clove_ui_flutter/src/elements/complex_painter/controller/layer_controller.dart';
import 'package:clove_ui_flutter/src/elements/complex_painter/controller/paint_controller.dart';
import 'package:flutter/foundation.dart';

import 'controller/matrix_controller.dart';

class ComplexPainterController extends ChangeNotifier {
  final LayerController layerController = LayerController();
  final MatrixController matrixController = MatrixController();
  final PaintController paintController = PaintController();

  ComplexPainterController() {
    paintController.layerController = layerController;
    paintController.matrixController = matrixController;
  }

  void onScaleStart(e) {}

  void onScaleUpdate(e) {}

  void onScaleEnd(e) {}
}
