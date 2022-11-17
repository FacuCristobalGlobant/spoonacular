import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

abstract class AssetToHtml {
  static Widget convert(String pathToAsset) {
    return Html(
      data: '<svg>$pathToAsset<svg>',
    );
  }
}
