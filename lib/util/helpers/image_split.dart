import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as imglib;

class ImageHelper {
  static List<Uint8List> split(String input, int gridSize) {
    final image = imglib.decodeImage(File(input).readAsBytesSync())!;
    final width = (image.width / gridSize).round();
    final height = (image.height / gridSize).round();

    // split image to parts
    List<imglib.Image> parts = [];
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        parts.add(imglib.copyCrop(image, j * width, i * height, width, height));
      }
    }

    // convert image from image package to Uint8List
    List<Uint8List> output = [];
    for (var img in parts) {
      output.add(Uint8List.fromList(imglib.encodePng(img)));
    }
    return output;
  }

  static Image fromUint8List(
    Uint8List image, {
    double? scale,
    BoxFit? fit,
    double? height,
    double? width,
    String? semanticLabel,
  }) {
    return Image.memory(
      image,
      scale: scale ?? 1.0,
      fit: fit,
      height: height,
      width: width,
      semanticLabel: semanticLabel,
    );
  }
}
