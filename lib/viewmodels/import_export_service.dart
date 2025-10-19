import '../models/widget_node.dart';
import '../models/app_theme.dart';
import 'package:flutter_glimpse/flutter_glimpse.dart';
import 'dart:convert';
import 'dart:io';

class ImportExportService {
  static Map<String, dynamic> exportProject(WidgetNode root, AppTheme theme, String? selectedWidgetId) {
    return {
      'scaffoldWidget': root.toJson(),
      'appTheme': theme.toJson(),
      'selectedWidgetId': selectedWidgetId,
    };
  }

  static void importProject(
    Map<String, dynamic> data, {
    required void Function(WidgetNode) setRoot,
    required void Function(AppTheme) setTheme,
    required void Function(String?) setSelectedWidgetId,
  }) {
    try {
      final root = WidgetNode.fromJson(data['scaffoldWidget']);
      final theme = AppTheme.fromJson(data['appTheme']);
      final selectedWidgetId = data['selectedWidgetId'];
      setRoot(root);
      setTheme(theme);
      setSelectedWidgetId(selectedWidgetId);
    } catch (e) {
      // Handle import error
    }
  }

  static Future<void> exportToFile(String filePath, GlimpseWidget glimpseWidget) async {
    final glimpseJson = GlimpseParser.toJson(glimpseWidget);
    final jsonString = jsonEncode(glimpseJson);
    final file = File(filePath);
    await file.writeAsString(jsonString);
  }

  static String exportToJsonString(GlimpseWidget glimpseWidget) {
    final glimpseJson = GlimpseParser.toJson(glimpseWidget);
    return jsonEncode(glimpseJson);
  }
} 