import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart' as mat;

import '../complex_painter_enum.dart';

class PaintRecord {
  Paint paint;
  PainterType painterType;
  Path? path;
  Image? image;
  Image? realImage;
  Offset? offset;
  bool isMirror = false;
  bool isSelected = false;
  bool isMask;
  bool saveLayer;
  BackgroundType? drawBgType;
  Color? bgColor;
  mat.Gradient? bgGradient;
  Image? bgImage;
  double rotate = 0;
  mat.BoxFit boxFit;

  PaintRecord._({
    required this.paint,
    required this.painterType,
    this.path,
    this.image,
    this.offset,
    this.realImage,
    this.isMask = false,
    this.drawBgType,
    this.bgColor,
    this.bgGradient,
    this.bgImage,
    this.boxFit = mat.BoxFit.contain,
    this.saveLayer = false,
  });

  factory PaintRecord.pencil({
    required Paint paint,
    required Path path,
  }) {
    return PaintRecord._(
      paint: paint,
      painterType: PainterType.pencil,
      path: path,
    );
  }

  factory PaintRecord.rubber({
    required Paint paint,
    required Path path,
  }) {
    return PaintRecord._(
      paint: paint,
      painterType: PainterType.rubber,
      path: path,
    );
  }

  factory PaintRecord.rope({
    required Paint paint,
    required Path path,
  }) {
    return PaintRecord._(
      paint: paint,
      painterType: PainterType.rope,
      path: path,
    );
  }

  factory PaintRecord.image({
    required Paint paint,
    required Image image,
    Offset? offset,
    Image? realImage,
    bool isMask = false,
    mat.BoxFit? boxFit,
    bool? saveLayer,
  }) {
    return PaintRecord._(
      paint: paint,
      painterType: PainterType.image,
      image: image,
      offset: offset,
      realImage: realImage,
      isMask: isMask,
      boxFit: boxFit ?? mat.BoxFit.contain,
      saveLayer: saveLayer ?? false,
    );
  }

  factory PaintRecord.background({
    required Paint paint,
    required BackgroundType type,
    Offset? offset,
    Color? bgColor,
    mat.Gradient? bgGradient,
    Image? bgImage,
    mat.BoxFit? boxFit,
  }) {
    return PaintRecord._(
      paint: paint,
      painterType: PainterType.background,
      drawBgType: type,
      offset: offset,
      bgColor: bgColor,
      bgGradient: bgGradient,
      bgImage: bgImage,
      boxFit: boxFit ?? mat.BoxFit.contain,
    );
  }
}
