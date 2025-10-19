import 'package:flutter/material.dart';
import '../models/widget_node.dart';
import '../models/app_theme.dart';
import 'package:flutter_glimpse/flutter_glimpse.dart';

class PreviewWidgetService {
  /// Returns a preview widget for the given WidgetNode and theme.
  static Widget buildPreviewWidget(WidgetNode node, AppTheme appTheme) {
    final glimpseWidget = _toGlimpseWidget(node);
    if (glimpseWidget != null) {
      return glimpseWidget.toFlutterWidget();
    }
    return const Center(child: Text('Unsupported widget type in preview'));
  }

  /// Converts a WidgetNode to a Glimpse widget instance using the Glimpse package.
  static GlimpseWidget? _toGlimpseWidget(WidgetNode node) {
    try {
      switch (node.type) {
        case 'GlimpseImage':
          return GlimpseImage("");
        case 'GlimpseText':
          return GlimpseText('Hello, World!');
        case 'GlimpseColumn':
          return GlimpseColumn(children: []);
        case 'GlimpseRow':
          return GlimpseRow(children: []);
        case 'GlimpseContainer':
          return GlimpseContainer();
        case 'GlimpseScaffold':
          return GlimpseScaffold();
        case 'GlimpseSizedBox':
          return GlimpseSizedBox();
        case 'GlimpseSpacer':
          return GlimpseSpacer();
        case 'GlimpseIcon':
          return GlimpseIcon();
        // Add more Glimpse widget types as needed
        default:
          return null;
      }
    } catch (e) {
      debugPrint('Glimpse conversion error: $e');
      return null;
    }
  }
} 