import 'package:flutter/material.dart';
import 'package:flutter_glimpse/flutter_glimpse.dart';
import '../models/widget_node.dart';
import '../models/widget_registry.dart';

class GlimpseConversionService {
  static GlimpseWidget widgetNodeToGlimpseWidget(WidgetNode node) {
    final children = node.children.map(widgetNodeToGlimpseWidget).toList();
    switch (node.type) {
      case 'GlimpseColumn':
        return GlimpseColumn(
          children: children,
          mainAxisAlignment: _parseMainAxisAlignment(node.properties['mainAxisAlignment']),
          mainAxisSize: _parseMainAxisSize(node.properties['mainAxisSize']),
          crossAxisAlignment: _parseCrossAxisAlignment(node.properties['crossAxisAlignment']),
          textDirection: _parseTextDirection(node.properties['textDirection']),
          verticalDirection: _parseVerticalDirection(node.properties['verticalDirection']),
          textBaseline: _parseTextBaseline(node.properties['textBaseline']),
        );
      case 'GlimpseRow':
        return GlimpseRow(
          children: children,
          mainAxisAlignment: _parseMainAxisAlignment(node.properties['mainAxisAlignment']),
          mainAxisSize: _parseMainAxisSize(node.properties['mainAxisSize']),
          crossAxisAlignment: _parseCrossAxisAlignment(node.properties['crossAxisAlignment']),
          textDirection: _parseTextDirection(node.properties['textDirection']),
          verticalDirection: _parseVerticalDirection(node.properties['verticalDirection']),
          textBaseline: _parseTextBaseline(node.properties['textBaseline']),
        );
      case 'GlimpseContainer':
        return GlimpseContainer(
          child: children.isNotEmpty ? children.first : null,
          width: _parseDouble(node.properties['width']),
          height: _parseDouble(node.properties['height']),
          color: _parseColor(node.properties['color']),
          alignment: _parseAlignment(node.properties['alignment']),
          padding: _parseEdgeInsets(node.properties['padding']),
          margin: _parseEdgeInsets(node.properties['margin']),
          decoration: _parseBoxDecoration(node.properties),
          constraints: null,
          transform: null,
          transformAlignment: null,
          clipBehavior: _parseClip(node.properties['clipBehavior']),
        );
      case 'GlimpseText':
        return GlimpseText(
          node.properties['text']?.toString() ?? '',
          fontSize: _parseDouble(node.properties['fontSize']),
          fontWeight: _parseFontWeight(node.properties['fontWeight']),
          color: _parseColor(node.properties['color']),
          textAlign: _parseTextAlign(node.properties['textAlign']),
          fontFamily: node.properties['fontFamily']?.toString(),
          letterSpacing: _parseDouble(node.properties['letterSpacing']),
          wordSpacing: _parseDouble(node.properties['wordSpacing']),
          height: _parseDouble(node.properties['height']),
          maxLines: _parseInt(node.properties['maxLines']),
          overflow: _parseTextOverflow(node.properties['overflow']),
          softWrap: node.properties['softWrap'] as bool?,
          decoration: _parseTextDecoration(node.properties['decoration']),
          textDirection: _parseTextDirection(node.properties['textDirection']),
        );
      case 'GlimpseImage':
        return GlimpseImage(
          node.properties['src']?.toString() ?? '',
          width: _parseDouble(node.properties['width']),
          height: _parseDouble(node.properties['height']),
          fit: _parseBoxFit(node.properties['fit']),
          alignment: _parseAlignment(node.properties['alignment']),
          repeat: _parseImageRepeat(node.properties['repeat']),
          color: _parseColor(node.properties['color']),
          colorBlendMode: _parseBlendMode(node.properties['colorBlendMode']),
          centerSlice: null,
          matchTextDirection: node.properties['matchTextDirection'] as bool? ?? false,
          gaplessPlayback: node.properties['gaplessPlayback'] as bool? ?? false,
          filterQuality: _parseFilterQuality(node.properties['filterQuality']),
          cacheWidth: _parseInt(node.properties['cacheWidth']),
          cacheHeight: _parseInt(node.properties['cacheHeight']),
          scale: _parseDouble(node.properties['scale']) ?? 1.0,
          semanticLabel: node.properties['semanticLabel']?.toString(),
        );
      case 'GlimpseIcon':
        return GlimpseIcon(
          icon: null,
          size: _parseDouble(node.properties['size']),
          color: _parseColor(node.properties['color']),
          semanticLabel: node.properties['semanticLabel']?.toString(),
          textDirection: _parseTextDirection(node.properties['textDirection']),
          opacity: _parseDouble(node.properties['opacity']),
          applyTextScaling: node.properties['applyTextScaling'] as bool?,
          shadows: null,
        );
      case 'GlimpseSpacer':
        return GlimpseSpacer(flex: _parseInt(node.properties['flex']) ?? 1);
      case 'GlimpseSizedBox':
        return GlimpseSizedBox(
          width: _parseDouble(node.properties['width']),
          height: _parseDouble(node.properties['height']),
          child: children.isNotEmpty ? children.first : null,
        );
      case 'GlimpseScaffold':
        // Create AppBar if showAppBar is true and appBarTitle is provided
        GlimpseAppBar? appBar;
        final showAppBar = node.properties['showAppBar'] as bool? ?? true;
        final appBarTitle = node.properties['appBarTitle']?.toString();
        if (showAppBar && appBarTitle != null && appBarTitle.isNotEmpty) {
          appBar = GlimpseAppBar(
            title: appBarTitle,
            backgroundColor: _parseColor(node.properties['appBarBackgroundColor']),
          );
        }
        
        return GlimpseScaffold(
          appBar: appBar,
          backgroundColor: _parseColor(node.properties['backgroundColor']),
          resizeToAvoidBottomInset: node.properties['resizeToAvoidBottomInset'] as bool?,
          primary: node.properties['primary'] as bool? ?? true,
          floatingActionButtonLocation: null,
          extendBody: node.properties['extendBody'] as bool? ?? false,
          extendBodyBehindAppBar: node.properties['extendBodyBehindAppBar'] as bool? ?? false,
          drawerScrimColor: _parseColor(node.properties['drawerScrimColor']),
          drawerEdgeDragWidth: _parseDouble(node.properties['drawerEdgeDragWidth']),
          drawerEnableOpenDragGesture: node.properties['drawerEnableOpenDragGesture'] as bool? ?? true,
          endDrawerEnableOpenDragGesture: node.properties['endDrawerEnableOpenDragGesture'] as bool? ?? true,
          body: children.isNotEmpty ? children.first : null,
        );
      default:
        return GlimpseContainer();
    }
  }

  static WidgetNode widgetNodeFromGlimpseWidget(dynamic glimpseWidget) {
    if (glimpseWidget == null) {
      throw Exception('Tried to convert a null Glimpse widget');
    }
    String type = glimpseWidget.runtimeType.toString();
    String label = WidgetRegistry.getLabel(type);
    IconData icon = WidgetRegistry.getIcon(type);
    Offset position = const Offset(10, 10);
    Size size = const Size(200, 100);
    List<WidgetNode> children = [];
    if (glimpseWidget is GlimpseColumn || glimpseWidget is GlimpseRow) {
      if (glimpseWidget.children != null) {
        children = (glimpseWidget.children as List)
            .where((child) => child != null)
            .map((child) => widgetNodeFromGlimpseWidget(child))
            .toList();
      }
    } else if (glimpseWidget is GlimpseContainer && glimpseWidget.child != null) {
      children = [widgetNodeFromGlimpseWidget(glimpseWidget.child!)];
    } else if (glimpseWidget is GlimpseScaffold && glimpseWidget.body != null) {
      children = [widgetNodeFromGlimpseWidget(glimpseWidget.body!)];
    } else if (glimpseWidget is GlimpseSizedBox && glimpseWidget.child != null) {
      children = [widgetNodeFromGlimpseWidget(glimpseWidget.child!)];
    }
    Map<String, dynamic> properties = {};
    if (glimpseWidget is GlimpseContainer) {
      if (glimpseWidget.width != null) properties['width'] = glimpseWidget.width;
      if (glimpseWidget.height != null) properties['height'] = glimpseWidget.height;
      if (glimpseWidget.alignment != null) properties['alignment'] = glimpseWidget.alignment.toString();
      if (glimpseWidget.color != null) {
        properties['color'] = '#${glimpseWidget.color!.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
      }
      if (glimpseWidget.padding != null) properties['padding'] = glimpseWidget.padding;
      if (glimpseWidget.margin != null) properties['margin'] = glimpseWidget.margin;
      if (glimpseWidget.decoration != null) {
        final BoxDecoration decoration = glimpseWidget.decoration!;
        if (decoration.borderRadius != null && decoration.borderRadius is BorderRadius) {
          final BorderRadius br = decoration.borderRadius as BorderRadius;
          if (br.topLeft == br.topRight && br.topLeft == br.bottomLeft && br.topLeft == br.bottomRight) {
            properties['borderRadius'] = br.topLeft.x;
          }
        }
        if (decoration.border != null && decoration.border is Border) {
          final Border border = decoration.border as Border;
          if (border.top.width == border.right.width && border.top.width == border.bottom.width && border.top.width == border.left.width) {
            properties['borderWidth'] = border.top.width;
          }
          if (border.top.color == border.right.color && border.top.color == border.bottom.color && border.top.color == border.left.color) {
            properties['borderColor'] = '#${border.top.color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
          }
        }
        if (decoration.color != null) {
          properties['color'] = '#${decoration.color!.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
        }
      }
      if (glimpseWidget.clipBehavior != null) properties['clipBehavior'] = glimpseWidget.clipBehavior.toString();
    } else if (glimpseWidget is GlimpseRow || glimpseWidget is GlimpseColumn) {
      if (glimpseWidget.mainAxisAlignment != null) properties['mainAxisAlignment'] = glimpseWidget.mainAxisAlignment.toString().split('.').last;
      if (glimpseWidget.mainAxisSize != null) properties['mainAxisSize'] = glimpseWidget.mainAxisSize.toString().split('.').last;
      if (glimpseWidget.crossAxisAlignment != null) properties['crossAxisAlignment'] = glimpseWidget.crossAxisAlignment.toString().split('.').last;
      if (glimpseWidget.textDirection != null) properties['textDirection'] = glimpseWidget.textDirection.toString().split('.').last;
      if (glimpseWidget.verticalDirection != null) properties['verticalDirection'] = glimpseWidget.verticalDirection.toString().split('.').last;
      if (glimpseWidget.textBaseline != null) properties['textBaseline'] = glimpseWidget.textBaseline.toString().split('.').last;
    }
    if (glimpseWidget is GlimpseScaffold) {
      if (glimpseWidget.backgroundColor != null) {
        properties['backgroundColor'] = '#${glimpseWidget.backgroundColor!.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
      }
      if (glimpseWidget.primary != null) properties['primary'] = glimpseWidget.primary;
      if (glimpseWidget.extendBody != null) properties['extendBody'] = glimpseWidget.extendBody;
      if (glimpseWidget.extendBodyBehindAppBar != null) properties['extendBodyBehindAppBar'] = glimpseWidget.extendBodyBehindAppBar;
      if (glimpseWidget.drawerEnableOpenDragGesture != null) properties['drawerEnableOpenDragGesture'] = glimpseWidget.drawerEnableOpenDragGesture;
      if (glimpseWidget.endDrawerEnableOpenDragGesture != null) properties['endDrawerEnableOpenDragGesture'] = glimpseWidget.endDrawerEnableOpenDragGesture;
      
      // Handle AppBar properties
      if (glimpseWidget.appBar is GlimpseAppBar) {
        properties['showAppBar'] = true;
        final appBar = glimpseWidget.appBar as GlimpseAppBar;
        if (appBar.title != null) properties['appBarTitle'] = appBar.title;
        if (appBar.backgroundColor != null) {
          properties['appBarBackgroundColor'] = '#${appBar.backgroundColor!.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
        }
      } else {
        properties['showAppBar'] = false;
      }
    }
    if (glimpseWidget is GlimpseText) {
      properties['text'] = glimpseWidget.text;
      properties['textAlign'] = glimpseWidget.textAlign?.toString();
      properties['fontFamily'] = glimpseWidget.fontFamily;
      if (glimpseWidget.color != null) {
        properties['color'] = '#${glimpseWidget.color!.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
      }
    }
    if (glimpseWidget is GlimpseImage) {
      if (glimpseWidget.src != null) properties['src'] = glimpseWidget.src;
      if (glimpseWidget.width != null) properties['width'] = glimpseWidget.width;
      if (glimpseWidget.height != null) properties['height'] = glimpseWidget.height;
      if (glimpseWidget.fit != null) properties['fit'] = glimpseWidget.fit.toString();
      if (glimpseWidget.alignment != null) properties['alignment'] = glimpseWidget.alignment.toString();
      if (glimpseWidget.repeat != null) properties['repeat'] = glimpseWidget.repeat.toString();
      if (glimpseWidget.color != null) {
        properties['color'] = '#${glimpseWidget.color!.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
      }
      if (glimpseWidget.filterQuality != null) properties['filterQuality'] = glimpseWidget.filterQuality.toString();
      if (glimpseWidget.scale != null) properties['scale'] = glimpseWidget.scale;
    }
    if (glimpseWidget is GlimpseIcon) {
      if (glimpseWidget.icon != null) properties['icon'] = glimpseWidget.icon.toString();
      if (glimpseWidget.size != null) properties['size'] = glimpseWidget.size;
      if (glimpseWidget.color != null) {
        properties['color'] = '#${glimpseWidget.color!.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
      }
    }
    return WidgetNode(
      uid: UniqueKey().toString(),
      type: type,
      label: label,
      icon: icon,
      position: position,
      size: size,
      children: children,
      properties: properties,
    );
  }

  // --- Property parsing helpers (move all _parse* helpers here as static methods) ---
  static MainAxisAlignment? _parseMainAxisAlignment(dynamic value) {
    switch (value) {
      case 'start': return MainAxisAlignment.start;
      case 'end': return MainAxisAlignment.end;
      case 'center': return MainAxisAlignment.center;
      case 'spaceBetween': return MainAxisAlignment.spaceBetween;
      case 'spaceAround': return MainAxisAlignment.spaceAround;
      case 'spaceEvenly': return MainAxisAlignment.spaceEvenly;
      default: return null;
    }
  }
  static MainAxisSize? _parseMainAxisSize(dynamic value) {
    switch (value) {
      case 'min': return MainAxisSize.min;
      case 'max': return MainAxisSize.max;
      default: return null;
    }
  }
  static CrossAxisAlignment? _parseCrossAxisAlignment(dynamic value) {
    switch (value) {
      case 'start': return CrossAxisAlignment.start;
      case 'end': return CrossAxisAlignment.end;
      case 'center': return CrossAxisAlignment.center;
      case 'stretch': return CrossAxisAlignment.stretch;
      case 'baseline': return CrossAxisAlignment.baseline;
      default: return null;
    }
  }
  static TextDirection? _parseTextDirection(dynamic value) {
    switch (value) {
      case 'ltr': return TextDirection.ltr;
      case 'rtl': return TextDirection.rtl;
      default: return null;
    }
  }
  static VerticalDirection? _parseVerticalDirection(dynamic value) {
    switch (value) {
      case 'down': return VerticalDirection.down;
      case 'up': return VerticalDirection.up;
      default: return null;
    }
  }
  static TextBaseline? _parseTextBaseline(dynamic value) {
    switch (value) {
      case 'alphabetic': return TextBaseline.alphabetic;
      case 'ideographic': return TextBaseline.ideographic;
      default: return null;
    }
  }
  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString());
  }
  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    return int.tryParse(value.toString());
  }
  static Color? _parseColor(dynamic value) {
    if (value == null || value == '') return null;
    try {
      if (value is Color) return value;
      if (value is String && value.startsWith('#')) {
        return Color(int.parse(value.replaceFirst('#', '0x')));
      }
    } catch (_) {}
    return null;
  }
  static Alignment? _parseAlignment(dynamic value) {
    switch (value) {
      case 'topLeft': return Alignment.topLeft;
      case 'topCenter': return Alignment.topCenter;
      case 'topRight': return Alignment.topRight;
      case 'centerLeft': return Alignment.centerLeft;
      case 'center': return Alignment.center;
      case 'centerRight': return Alignment.centerRight;
      case 'bottomLeft': return Alignment.bottomLeft;
      case 'bottomCenter': return Alignment.bottomCenter;
      case 'bottomRight': return Alignment.bottomRight;
      default: return null;
    }
  }
  static EdgeInsets? _parseEdgeInsets(dynamic value) {
    if (value == null) return null;
    if (value is double) return EdgeInsets.all(value);
    if (value is int) return EdgeInsets.all(value.toDouble());
    return null;
  }
  static BoxDecoration? _parseBoxDecoration(Map<String, dynamic> props) {
    final color = _parseColor(props['color']);
    final borderRadius = _parseDouble(props['borderRadius']);
    final borderWidth = _parseDouble(props['borderWidth']);
    final borderColor = _parseColor(props['borderColor']);
    if (color == null && borderRadius == null && borderWidth == null) return null;
    return BoxDecoration(
      color: color,
      borderRadius: borderRadius != null ? BorderRadius.circular(borderRadius) : null,
      border: borderWidth != null && borderWidth > 0
          ? Border.all(color: borderColor ?? const Color(0xFF666666), width: borderWidth)
          : null,
    );
  }
  static Clip? _parseClip(dynamic value) {
    switch (value) {
      case 'none': return Clip.none;
      case 'hardEdge': return Clip.hardEdge;
      case 'antiAlias': return Clip.antiAlias;
      case 'antiAliasWithSaveLayer': return Clip.antiAliasWithSaveLayer;
      default: return null;
    }
  }
  static FontWeight? _parseFontWeight(dynamic value) {
    switch (value) {
      case 'bold': return FontWeight.bold;
      case 'normal': return FontWeight.normal;
      case 'w100': return FontWeight.w100;
      case 'w200': return FontWeight.w200;
      case 'w300': return FontWeight.w300;
      case 'w400': return FontWeight.w400;
      case 'w500': return FontWeight.w500;
      case 'w600': return FontWeight.w600;
      case 'w700': return FontWeight.w700;
      case 'w800': return FontWeight.w800;
      case 'w900': return FontWeight.w900;
      default: return null;
    }
  }
  static TextAlign? _parseTextAlign(dynamic value) {
    switch (value) {
      case 'left': return TextAlign.left;
      case 'right': return TextAlign.right;
      case 'center': return TextAlign.center;
      case 'justify': return TextAlign.justify;
      default: return null;
    }
  }
  static TextOverflow? _parseTextOverflow(dynamic value) {
    switch (value) {
      case 'clip': return TextOverflow.clip;
      case 'fade': return TextOverflow.fade;
      case 'ellipsis': return TextOverflow.ellipsis;
      case 'visible': return TextOverflow.visible;
      default: return null;
    }
  }
  static TextDecoration? _parseTextDecoration(dynamic value) {
    switch (value) {
      case 'underline': return TextDecoration.underline;
      case 'overline': return TextDecoration.overline;
      case 'lineThrough': return TextDecoration.lineThrough;
      default: return TextDecoration.none;
    }
  }
  static BoxFit? _parseBoxFit(dynamic value) {
    switch (value) {
      case 'fill': return BoxFit.fill;
      case 'contain': return BoxFit.contain;
      case 'cover': return BoxFit.cover;
      case 'fitWidth': return BoxFit.fitWidth;
      case 'fitHeight': return BoxFit.fitHeight;
      case 'none': return BoxFit.none;
      case 'scaleDown': return BoxFit.scaleDown;
      default: return null;
    }
  }
  static ImageRepeat? _parseImageRepeat(dynamic value) {
    switch (value) {
      case 'repeat': return ImageRepeat.repeat;
      case 'repeatX': return ImageRepeat.repeatX;
      case 'repeatY': return ImageRepeat.repeatY;
      case 'noRepeat': return ImageRepeat.noRepeat;
      default: return null;
    }
  }
  static BlendMode? _parseBlendMode(dynamic value) {
    if (value == null) return null;
    try {
      return BlendMode.values.firstWhere((e) => e.name == value);
    } catch (_) {}
    return null;
  }
  static FilterQuality? _parseFilterQuality(dynamic value) {
    switch (value) {
      case 'none': return FilterQuality.none;
      case 'low': return FilterQuality.low;
      case 'medium': return FilterQuality.medium;
      case 'high': return FilterQuality.high;
      default: return null;
    }
  }
} 