import 'package:clove_ui_flutter/src/elements/complex_painter/controller/layer_controller.dart';
import 'package:clove_ui_flutter/src/elements/complex_painter/controller/matrix_controller.dart';
import 'package:flutter/foundation.dart';

class PaintController extends ChangeNotifier {
  late final LayerController layerController;
  late final MatrixController matrixController;

  void onScaleStart(e) {}
 
  void onScaleUpdate(e) {}

  void onScaleEnd(e) {}
}
