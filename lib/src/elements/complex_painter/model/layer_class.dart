import 'dart:math';

import 'package:clove_ui_flutter/src/elements/complex_painter/enum/layer_enum.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class BasicLayer {
  final String id;
  final LayerType layerType;
  final ValueNotifier<int> refreshCount = ValueNotifier(0);
  bool isEditing;

  BasicLayer({
    String? id,
    required this.layerType,
    this.isEditing = false,
  }) : id = id ?? const Uuid().v1();

  void refresh() {}

  void resetStatus() {}
}

class ImageLayerInfo extends BasicLayer with ChangeNotifier {
  ///[size] 贴纸大小
  Size size;
  Offset offset = Offset.zero;
  bool isSelected = false;

  ImageLayerInfo({
    super.id,
    super.isEditing,
    this.size = Size.zero,
  }) : super(
          layerType: LayerType.image,
        );

  void setOffset(Offset value) {
    offset = value;
    xOffset = xOffset != 0 ? xOffset : value.dx;
    yOffset = yOffset != 0 ? yOffset : value.dy;
    rawOffset = value;
    notifyListeners();
  }

  GlobalKey stickerKey = GlobalKey();
  GlobalKey rotateIconKey = GlobalKey();
  GlobalKey constraintsKey = GlobalKey();
  late GlobalKey imgRatioCheckKey;

  bool isChanging = false;
  bool isMoving = false;
  bool isIconChanging = false;

  bool isFlip = false;

  double xOffset = 0;
  double yOffset = 0;

  Offset rawOffset = Offset.zero;

  double? initialDistance;
  Offset? initialCenter;

  double changeSize = 1;
  double rotate = 0;
  double scale = 1.0;
  double initialScale = 1.0;
  double initialRotate = 0;

  bool isLimit = false;

  double _marginSize = 18;

  double get marginSize => _marginSize;

  Matrix4 get matrix4_1 => Matrix4.identity()..translate(xOffset, yOffset);

  Matrix4 get matrix4_2 => Matrix4.identity()..scale(scale);

  Matrix4 get matrix4_3 => Matrix4.identity()
    ..setEntry(3, 2, 0.001) // Add a small z-offset to avoid rendering issues
    ..rotateZ(rotate);

  Matrix4 get matrix42Convert => Matrix4.inverted(matrix4_2);

  Matrix4 get matrix43Convert => Matrix4.inverted(matrix4_3);

  Duration get duration =>
      isChanging ? Duration.zero : const Duration(milliseconds: 300);

  Duration get iconDuration =>
      isIconChanging ? Duration.zero : const Duration(milliseconds: 300);

  @override
  void refresh() {
    refreshCount.value = refreshCount.value + 1;
  }

  Future<void> handleMakeMarginSize({double? ratio}) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final Size? constraintSize = constraintsKey.currentContext?.size;
    final Size? realSize = imgRatioCheckKey.currentContext?.size;
    if (constraintSize == null || realSize == null) {
      return;
    }
    double targetWidth = 36;
    double realWidth = realSize.width;
    double realHeight = realSize.height;
    double wRatio = constraintSize.width / realWidth;
    double hRatio = constraintSize.height / realHeight;
    if (ratio != null) {
      if (ratio >= 1) {
        hRatio = (constraintSize.width / ratio) / realSize.height;
      } else {
        wRatio = (constraintSize.height * ratio) / realSize.width;
      }
    }
    double cRatio = max(wRatio, hRatio);
    _marginSize = targetWidth * cRatio;
    notifyListeners();
  }

  void onTap() {
    isSelected = !isSelected;
    notifyListeners();
  }

  void handleChangeRotate(double angle) {
    const double epsilon = 0.1; // 允许的误差范围（弧度）
    // 将角度转换为0到2π之间的弧度值
    double normalizedAngle = angle % (2 * pi);
    if (normalizedAngle < 0) {
      normalizedAngle += 2 * pi; // 确保值为正
    }
    // 找到最接近的90度倍数
    const double piOver2 = pi / 2; // 90度对应的弧度值
    double closestMultipleOfPiOver2 =
        (normalizedAngle / piOver2).round() * piOver2;
    // 检查角度是否在最接近的90度倍数附近
    if ((normalizedAngle - closestMultipleOfPiOver2).abs() <= epsilon) {
      // 如果角度在最接近的90度倍数附近，则进行相应处理
      rotate = closestMultipleOfPiOver2; // 你可以将角度设置为最接近的90度倍数
      isLimit = true;
    } else {
      // 如果角度不在最接近的90度倍数附近，则正常处理
      rotate = angle;
      isLimit = false;
    }
    notifyListeners();
  }

  void onDoubleTap() {
    isChanging = false;
    notifyListeners();
    xOffset = rawOffset.dx;
    yOffset = rawOffset.dy;
    scale = 1;
    rotate = 0;
    changeSize = 0;
    notifyListeners();
  }

  void onScaleStart(e) {
    isChanging = true;
    isMoving = true;
    notifyListeners();
    initialScale = scale;
    initialRotate = rotate;
  }

  void onScaleUpdate(e) {
    xOffset += (e.focalPointDelta.dx) * scale;
    yOffset += (e.focalPointDelta.dy) * scale;
    if (e.pointerCount == 2) {
      /// 缩放范围
      /// 确保 scale 在 [_minScale] 和 [_maxScale] 之间
      scale = (initialScale * e.scale).clamp(0.5, 5);
      handleChangeRotate(initialRotate + e.rotation);
    }
    notifyListeners();
  }

  void onScaleEnd(e) {
    isLimit = false;
    isMoving = false;
    notifyListeners();
  }

  void handleChangeFlip() {
    isFlip = !isFlip;
    notifyListeners();
  }

  void onPointerDown(e) {
    isChanging = isIconChanging = true;
    initialScale = scale;
    initialRotate = rotate;
    notifyListeners();
  }

  // void onPointerMove(e, SelfImageEditorController controller) {
  //   ///获取贴纸全局坐标
  //   RenderBox stickerRenderBox =
  //       stickerKey.currentContext!.findRenderObject() as RenderBox;
  //
  //   ///实际组件大小
  //   RenderBox painterRenderBox =
  //       controller.globalKey.currentContext!.findRenderObject() as RenderBox;
  //
  //   Offset stickerGlobalOffset = stickerRenderBox.localToGlobal(
  //     Offset.zero,
  //   );
  //   Offset stickerLocalOffset = painterRenderBox.globalToLocal(
  //     stickerGlobalOffset,
  //   );
  //
  //   Offset localOffset = painterRenderBox.globalToLocal(
  //     e.position,
  //   );
  //
  //   final stickerSize = stickerRenderBox.size *
  //       initialScale *
  //       controller.matrixController.scale;
  //
  //   // 中心点坐标
  //   initialCenter ??= Offset(
  //     stickerLocalOffset.dx + stickerSize.width / 2,
  //     stickerLocalOffset.dy + stickerSize.height / 2,
  //   );
  //
  //   initialDistance ??= (Offset(
  //     stickerSize.width / 2,
  //     stickerSize.height / 2,
  //   )).distance;
  //
  //   Offset rotateDelta = localOffset - initialCenter!;
  //
  //   // 保存初始距离
  //   // 基于初始距离和当前距离计算缩放比例
  //   double newScale = rotateDelta.distance /
  //       initialDistance! /
  //       controller.matrixController.scale;
  //
  //   /// 缩放范围
  //   /// 确保 scale 在 [_minScale] 和 [_maxScale] 之间
  //   scale = (initialScale * newScale).clamp(0.5, 5);
  //   notifyListeners();
  //   // 计算旋转角度变化
  //   handleChangeRotate(
  //     rotateDelta.direction -
  //         atan(
  //           1 / stickerSize.aspectRatio,
  //         ),
  //   );
  // }

  void onPainterUp(e) {
    isIconChanging = false;
    initialDistance = null;
    initialCenter = null;
    isLimit = false;
    notifyListeners();
  }

  @override
  void resetStatus() {
    onDoubleTap();
  }
}

class PaintLayerInfo extends BasicLayer with ChangeNotifier {
  PaintLayerInfo({
    super.id,
    super.isEditing,
  }) : super(
          layerType: LayerType.paint,
        );

  @override
  void refresh() {
    refreshCount.value = refreshCount.value + 1;
  }
}

class TextLayerInfo extends BasicLayer with ChangeNotifier {
  String text;

  TextLayerInfo({
    super.id,
    super.isEditing,
    required this.text,
  }) : super(
          layerType: LayerType.text,
        );

  @override
  void refresh() {
    refreshCount.value = refreshCount.value + 1;
  }
}
