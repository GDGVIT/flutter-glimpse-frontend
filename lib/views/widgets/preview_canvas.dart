import 'package:flutter/material.dart';
import '../../models/widget_node.dart';
import '../../models/app_theme.dart';
import 'package:flutter_glimpse/flutter_glimpse.dart';
import '../../viewmodels/design_canvas_viewmodel.dart';
import 'preview_pane.dart';

class PreviewCanvas extends StatelessWidget {
  final WidgetNode widgetRoot;
  final AppTheme appTheme;

  const PreviewCanvas({
    super.key,
    required this.widgetRoot,
    required this.appTheme,
  });

  @override
  Widget build(BuildContext context) {
    final glimpseWidget = DesignCanvasViewModel().widgetNodeToGlimpseWidget(widgetRoot);
    return PreviewPane(sduiRoot: glimpseWidget.toFlutterWidget());
  }
} 