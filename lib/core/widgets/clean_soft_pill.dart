import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

/// Píldora/Badge elástica universal sin altura fija para evitar cortes de texto (Ley 1 Clean Soft UI).
/// Basada en simc/auto_size_text y gskinnerTeam/flutter-folio.
class CleanSoftPill extends StatelessWidget {
  final String text;
  final Widget? icon;
  final Widget? prefix;
  final Widget? suffix;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final BorderRadiusGeometry? borderRadius;
  final double minFontSize;
  final bool isFlexible;
  final MainAxisSize mainAxisSize;

  const CleanSoftPill({
    super.key,
    required this.text,
    this.icon,
    this.prefix,
    this.suffix,
    this.backgroundColor = const Color(0xFFF1F5F9),
    this.textColor = const Color(0xFF0F172A),
    this.borderColor,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w600,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    this.onTap,
    this.borderRadius,
    this.minFontSize = 9,
    this.isFlexible = true,
    this.mainAxisSize = MainAxisSize.min,
  });

  @override
  Widget build(BuildContext context) {
    final textWidget = AutoSizeText(
      text,
      maxLines: 1,
      minFontSize: minFontSize,
      stepGranularity: 0.5,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: 1.15,
      ),
    );

    final content = Row(
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (prefix != null) ...[
          prefix!,
          const SizedBox(width: 5),
        ] else if (icon != null) ...[
          icon!,
          const SizedBox(width: 5),
        ],
        if (isFlexible)
          Flexible(child: textWidget)
        else
          textWidget,
        if (suffix != null) ...[
          const SizedBox(width: 5),
          suffix!,
        ],
      ],
    );

    final decoration = BoxDecoration(
      color: backgroundColor,
      borderRadius: borderRadius ?? BorderRadius.circular(9999),
      border: borderColor != null ? Border.all(color: borderColor!, width: 1) : null,
    );

    final container = Container(
      padding: padding,
      constraints: const BoxConstraints(minHeight: 24),
      decoration: decoration,
      child: content,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: (borderRadius as BorderRadius?) ?? BorderRadius.circular(9999),
        child: container,
      );
    }

    return container;
  }
}

