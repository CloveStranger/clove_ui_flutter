import 'package:clove_ui_flutter/clove_ui_flutter.dart';
import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';

import '../complex_painter_enum.dart';
import '../controller/layer_controller.dart';
import '../model/layer_class.dart';
import 'image_layer/image_layer.dart';
import 'paint_layer/paint_layer.dart';
import 'text_layer/text_layer.dart';

class ComplexPainterLayer extends StatelessWidget {
  final bool isForeLayers;
  final ComplexPainterController controller;

  const ComplexPainterLayer({
    super.key,
    required this.isForeLayers,
    required this.controller,
  });

  List<Widget> _buildLayers(LayerController layerController) {
    final targetLayers =
        isForeLayers ? layerController.foreLayers : layerController.backLayers;
    return targetLayers.map((editorLayer) {
      switch (editorLayer.layerType) {
        case LayerType.image:
          return ImageLayer(
            imageLayerInfo: editorLayer as ImageLayerInfo,
            controller: controller,
          );
        case LayerType.paint:
          return PaintLayer(
            paintLayerInfo: editorLayer as PaintLayerInfo,
            controller: controller,
          );
        case LayerType.text:
          return const TextLayer();
        default:
          return const SizedBox();
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller.layerController,
      builder: (_, __) {
        final editorLayersInfo = controller.layerController;
        final layers = _buildLayers(editorLayersInfo);
        if (isForeLayers) {
          return DeferredPointerHandler(
            child: Stack(
              children: layers,
            ),
          );
        }
        return SizedBox(
          child: () {
            if (editorLayersInfo.hideBackLayer) {
              return const SizedBox();
            }
            return Stack(
              alignment: Alignment.center,
              children: layers,
            );
          }(),
        );
      },
    );
  }
}
