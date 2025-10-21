import '../models/widget_node.dart';
import '../models/app_theme.dart';
import '../viewmodels/design_canvas_viewmodel.dart';

class CodeGeneratorService {
  static String generateCode(WidgetNode scaffoldWidget, AppTheme theme) {
    // If root is Glimpse, output Dart code using Glimpse widgets
    if (scaffoldWidget.type.startsWith('Glimpse')) {
      final glimpseWidget = DesignCanvasViewModel().widgetNodeToGlimpseWidget(scaffoldWidget);
      final buffer = StringBuffer();
      buffer.writeln("import 'package:flutter/material.dart';");
      buffer.writeln("import 'package:flutter_glimpse/flutter_glimpse.dart';");
      buffer.writeln('');
      buffer.writeln('class GeneratedGlimpseWidget extends StatelessWidget {');
      buffer.writeln('  const GeneratedGlimpseWidget({super.key});');
      buffer.writeln('');
      buffer.writeln('  @override');
      buffer.writeln('  Widget build(BuildContext context) {');
      buffer.writeln('    return ${_generateGlimpseWidgetCode(glimpseWidget, 2)};');
      buffer.writeln('  }');
      buffer.writeln('}');
      return buffer.toString();
    }
    // Legacy: output Flutter widget code
    final buffer = StringBuffer();
    buffer.writeln('import \'package:flutter/material.dart\';');
    buffer.writeln('');
    buffer.writeln('class GeneratedWidget extends StatelessWidget {');
    buffer.writeln('  const GeneratedWidget({super.key});');
    buffer.writeln('');
    buffer.writeln('  @override');
    buffer.writeln('  Widget build(BuildContext context) {');
    buffer.writeln('    return ${_generateWidgetCode(scaffoldWidget, 2, theme)};');
    buffer.writeln('  }');
    buffer.writeln('}');
    return buffer.toString();
  }

  static String _generateGlimpseWidgetCode(dynamic glimpseWidget, int indent) {
    final indentStr = '  ' * indent;
    final buffer = StringBuffer();
    final type = glimpseWidget.runtimeType.toString();
    switch (type) {
      case 'GlimpseScaffold':
        buffer.write('GlimpseScaffold(');
        if (glimpseWidget.appBar != null) buffer.write('\n${indentStr}appBar: ${_generateGlimpseWidgetCode(glimpseWidget.appBar, indent + 1)},');
        if (glimpseWidget.backgroundColor != null) buffer.write('\n${indentStr}backgroundColor: Color(${glimpseWidget.backgroundColor.value}),');
        if (glimpseWidget.body != null) buffer.write('\n${indentStr}body: ${_generateGlimpseWidgetCode(glimpseWidget.body, indent + 1)},');
        buffer.write('\n${'  ' * (indent - 1)})');
        break;
      case 'GlimpseColumn':
        buffer.write('GlimpseColumn(');
        if (glimpseWidget.children != null && glimpseWidget.children.isNotEmpty) {
          buffer.write('\n${indentStr}children: [');
          for (final child in glimpseWidget.children) {
            buffer.write('\n$indentStr  ${_generateGlimpseWidgetCode(child, indent + 2)},');
          }
          buffer.write('\n$indentStr],');
        }
        if (glimpseWidget.mainAxisAlignment != null) buffer.write('\n${indentStr}mainAxisAlignment: MainAxisAlignment.${glimpseWidget.mainAxisAlignment.toString().split('.').last},');
        if (glimpseWidget.crossAxisAlignment != null) buffer.write('\n${indentStr}crossAxisAlignment: CrossAxisAlignment.${glimpseWidget.crossAxisAlignment.toString().split('.').last},');
        buffer.write('\n${'  ' * (indent - 1)})');
        break;
      case 'GlimpseRow':
        buffer.write('GlimpseRow(');
        if (glimpseWidget.children != null && glimpseWidget.children.isNotEmpty) {
          buffer.write('\n${indentStr}children: [');
          for (final child in glimpseWidget.children) {
            buffer.write('\n$indentStr  ${_generateGlimpseWidgetCode(child, indent + 2)},');
          }
          buffer.write('\n$indentStr],');
        }
        if (glimpseWidget.mainAxisAlignment != null) buffer.write('\n${indentStr}mainAxisAlignment: MainAxisAlignment.${glimpseWidget.mainAxisAlignment.toString().split('.').last},');
        if (glimpseWidget.crossAxisAlignment != null) buffer.write('\n${indentStr}crossAxisAlignment: CrossAxisAlignment.${glimpseWidget.crossAxisAlignment.toString().split('.').last},');
        buffer.write('\n${'  ' * (indent - 1)})');
        break;
      case 'GlimpseContainer':
        buffer.write('GlimpseContainer(');
        if (glimpseWidget.width != null) buffer.write('\n${indentStr}width: ${glimpseWidget.width},');
        if (glimpseWidget.height != null) buffer.write('\n${indentStr}height: ${glimpseWidget.height},');
        if (glimpseWidget.color != null) buffer.write('\n${indentStr}color: Color(${glimpseWidget.color.value}),');
        if (glimpseWidget.child != null) buffer.write('\n${indentStr}child: ${_generateGlimpseWidgetCode(glimpseWidget.child, indent + 1)},');
        buffer.write('\n${'  ' * (indent - 1)})');
        break;
      case 'GlimpseText':
        buffer.write('GlimpseText(');
        buffer.write("'${glimpseWidget.text.replaceAll("'", "\\'")}'");
        if (glimpseWidget.fontSize != null) buffer.write(', fontSize: ${glimpseWidget.fontSize}');
        if (glimpseWidget.color != null) buffer.write(', color: Color(${glimpseWidget.color.value})');
        if (glimpseWidget.textAlign != null) buffer.write(', textAlign: TextAlign.${glimpseWidget.textAlign.toString().split('.').last}');
        buffer.write(')');
        break;
      case 'GlimpseImage':
        buffer.write('GlimpseImage(');
        buffer.write("'${glimpseWidget.src}'");
        if (glimpseWidget.width != null) buffer.write(', width: ${glimpseWidget.width}');
        if (glimpseWidget.height != null) buffer.write(', height: ${glimpseWidget.height}');
        if (glimpseWidget.fit != null) buffer.write(', fit: BoxFit.${glimpseWidget.fit.toString().split('.').last}');
        buffer.write(')');
        break;
      case 'GlimpseIcon':
        buffer.write('GlimpseIcon(');
        if (glimpseWidget.icon != null) buffer.write('icon: ${glimpseWidget.icon},');
        if (glimpseWidget.size != null) buffer.write('size: ${glimpseWidget.size},');
        if (glimpseWidget.color != null) buffer.write('color: Color(${glimpseWidget.color.value}),');
        buffer.write(')');
        break;
      case 'GlimpseSpacer':
        buffer.write('GlimpseSpacer(');
        if (glimpseWidget.flex != null) buffer.write('flex: ${glimpseWidget.flex},');
        buffer.write(')');
        break;
      case 'GlimpseSizedBox':
        buffer.write('GlimpseSizedBox(');
        if (glimpseWidget.width != null) buffer.write('width: ${glimpseWidget.width},');
        if (glimpseWidget.height != null) buffer.write('height: ${glimpseWidget.height},');
        if (glimpseWidget.child != null) buffer.write('child: ${_generateGlimpseWidgetCode(glimpseWidget.child, indent + 1)},');
        buffer.write(')');
        break;
      case 'GlimpseAppBar':
        buffer.write('GlimpseAppBar(');
        if (glimpseWidget.title != null) buffer.write("title: '${glimpseWidget.title}',");
        if (glimpseWidget.backgroundColor != null) buffer.write('backgroundColor: Color(${glimpseWidget.backgroundColor.value}),');
        if (glimpseWidget.foregroundColor != null) buffer.write('foregroundColor: Color(${glimpseWidget.foregroundColor.value}),');
        if (glimpseWidget.elevation != null) buffer.write('elevation: ${glimpseWidget.elevation},');
        if (glimpseWidget.centerTitle != null) buffer.write('centerTitle: ${glimpseWidget.centerTitle},');
        if (glimpseWidget.toolbarHeight != null) buffer.write('toolbarHeight: ${glimpseWidget.toolbarHeight},');
        if (glimpseWidget.leadingWidth != null) buffer.write('leadingWidth: ${glimpseWidget.leadingWidth},');
        if (glimpseWidget.automaticallyImplyLeading != null) buffer.write('automaticallyImplyLeading: ${glimpseWidget.automaticallyImplyLeading},');
        if (glimpseWidget.titleSpacing != null) buffer.write('titleSpacing: ${glimpseWidget.titleSpacing},');
        if (glimpseWidget.toolbarOpacity != null) buffer.write('toolbarOpacity: ${glimpseWidget.toolbarOpacity},');
        if (glimpseWidget.bottomOpacity != null) buffer.write('bottomOpacity: ${glimpseWidget.bottomOpacity},');
        buffer.write(')');
        break;
      default:
        buffer.write('Container()');
    }
    return buffer.toString();
  }

  static String _generateWidgetCode(WidgetNode node, int indent, AppTheme theme) {
    final indentStr = '  ' * indent;
    final buffer = StringBuffer();
    
    switch (node.type) {
      case 'Scaffold':
        buffer.write('Scaffold(');
        if (node.properties['backgroundColor'] != null) {
          final color = node.properties['backgroundColor'].toString();
          buffer.write('\n$indentStr  backgroundColor: Color(${color.replaceFirst('#', '0x')}),');
        }
        if (node.children.isNotEmpty) {
          buffer.write('\n$indentStr  body: ${_generateWidgetCode(node.children.first, indent + 1, theme)},');
        }
        buffer.write('\n$indentStr)');
        break;
        
      case 'Container Widget':
        buffer.write('Container(');
        if (node.properties['width'] != null) {
          buffer.write('\n$indentStr  width: ${node.properties['width']},');
        }
        if (node.properties['height'] != null) {
          buffer.write('\n$indentStr  height: ${node.properties['height']},');
        }
        if (node.properties['padding'] != null && node.properties['padding'] > 0) {
          buffer.write('\n$indentStr  padding: EdgeInsets.all(${node.properties['padding']}),');
        }
        if (node.properties['margin'] != null && node.properties['margin'] > 0) {
          buffer.write('\n$indentStr  margin: EdgeInsets.all(${node.properties['margin']}),');
        }
        
        final hasDecoration = node.properties['color'] != null || 
                            node.properties['borderRadius'] != null ||
                            node.properties['borderWidth'] != null;
        if (hasDecoration) {
          buffer.write('\n$indentStr  decoration: BoxDecoration(');
          if (node.properties['color'] != null) {
            final color = node.properties['color'].toString();
            buffer.write('\n$indentStr    color: Color(${color.replaceFirst('#', '0x')}),');
          }
          if (node.properties['borderRadius'] != null) {
            buffer.write('\n$indentStr    borderRadius: BorderRadius.circular(${node.properties['borderRadius']}),');
          }
          if (node.properties['borderWidth'] != null && node.properties['borderWidth'] > 0) {
            final borderColor = node.properties['borderColor']?.toString() ?? '#FF666666';
            buffer.write('\n$indentStr    border: Border.all(');
            buffer.write('\n$indentStr      color: Color(${borderColor.replaceFirst('#', '0x')}),');
            buffer.write('\n$indentStr      width: ${node.properties['borderWidth']},');
            buffer.write('\n$indentStr    ),');
          }
          buffer.write('\n$indentStr  ),');
        }
        
        if (node.children.isNotEmpty) {
          buffer.write('\n$indentStr  child: ${_generateWidgetCode(node.children.first, indent + 1, theme)},');
        }
        buffer.write('\n$indentStr)');
        break;
        
      case 'Row Widget':
        buffer.write('Row(');
        if (node.properties['mainAxisAlignment'] != null) {
          buffer.write('\n$indentStr  mainAxisAlignment: MainAxisAlignment.${node.properties['mainAxisAlignment']},');
        }
        if (node.properties['crossAxisAlignment'] != null) {
          buffer.write('\n$indentStr  crossAxisAlignment: CrossAxisAlignment.${node.properties['crossAxisAlignment']},');
        }
        if (node.children.isNotEmpty) {
          buffer.write('\n$indentStr  children: [');
          for (final child in node.children) {
            buffer.write('\n$indentStr    ${_generateWidgetCode(child, indent + 2, theme)},');
          }
          buffer.write('\n$indentStr  ],');
        }
        buffer.write('\n$indentStr)');
        break;
        
      case 'Column Widget':
        buffer.write('Column(');
        if (node.properties['mainAxisAlignment'] != null) {
          buffer.write('\n$indentStr  mainAxisAlignment: MainAxisAlignment.${node.properties['mainAxisAlignment']},');
        }
        if (node.properties['crossAxisAlignment'] != null) {
          buffer.write('\n$indentStr  crossAxisAlignment: CrossAxisAlignment.${node.properties['crossAxisAlignment']},');
        }
        if (node.children.isNotEmpty) {
          buffer.write('\n$indentStr  children: [');
          for (final child in node.children) {
            buffer.write('\n$indentStr    ${_generateWidgetCode(child, indent + 2, theme)},');
          }
          buffer.write('\n$indentStr  ],');
        }
        buffer.write('\n$indentStr)');
        break;
        
      case 'Text Widget':
        final text = node.properties['text']?.toString() ?? 'Text';
        buffer.write('Text(');
        buffer.write('\n$indentStr  \'$text\',');
        buffer.write('\n$indentStr  style: TextStyle(');
        if (node.properties['fontSize'] != null) {
          buffer.write('\n$indentStr    fontSize: ${node.properties['fontSize']},');
        }
        if (node.properties['color'] != null) {
          final color = node.properties['color'].toString();
          buffer.write('\n$indentStr    color: Color(${color.replaceFirst('#', '0x')}),');
        }
        if (node.properties['fontWeight'] != null && node.properties['fontWeight'] != 'normal') {
          buffer.write('\n$indentStr    fontWeight: FontWeight.${node.properties['fontWeight']},');
        }
        buffer.write('\n$indentStr  ),');
        if (node.properties['textAlign'] != null && node.properties['textAlign'] != 'left') {
          buffer.write('\n$indentStr  textAlign: TextAlign.${node.properties['textAlign']},');
        }
        buffer.write('\n$indentStr)');
        break;
        
      case 'TextField Widget':
        buffer.write('TextField(');
        buffer.write('\n$indentStr  decoration: InputDecoration(');
        if (node.properties['hintText'] != null) {
          buffer.write('\n$indentStr    hintText: \'${node.properties['hintText']}\',');
        }
        if (node.properties['labelText'] != null) {
          buffer.write('\n$indentStr    labelText: \'${node.properties['labelText']}\',');
        }
        buffer.write('\n$indentStr  ),');
        if (node.properties['obscureText'] == true) {
          buffer.write('\n$indentStr  obscureText: true,');
        }
        if (node.properties['maxLines'] != null && node.properties['maxLines'] != 1) {
          buffer.write('\n$indentStr  maxLines: ${(node.properties['maxLines'] as double).toInt()},');
        }
        buffer.write('\n$indentStr)');
        break;
        
      default:
        buffer.write('Container()');
    }
    
    return buffer.toString();
  }

} 