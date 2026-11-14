import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'clean_soft_pill.dart';

/// Barra horizontal tipo píldora estilo Sweet Crumb blindada con Stack 100% de ancho (Ley 2 Clean Soft UI).
class SweetCrumbProgressPill extends StatelessWidget {
  final Widget? avatar;
  final String title;
  final String subtitle;
  final double percentage; // 0.0 a 1.0
  final String? percentageLabel;
  final Color progressColor;
  final Color baseColor;
  final VoidCallback? onTap;

  const SweetCrumbProgressPill({
    super.key,
    this.avatar,
    required this.title,
    required this.subtitle,
    required this.percentage,
    this.percentageLabel,
    this.progressColor = const Color(0xFF1E40AF),
    this.baseColor = const Color(0xFFF1F5F9),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final clampedRatio = percentage.clamp(0.0, 1.0);
    final displayPercent = percentageLabel ?? '${(clampedRatio * 100).toInt()}%';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          constraints: const BoxConstraints(minHeight: 52),
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: BorderRadius.circular(30),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              // Capa 1: Fondo de progreso coloreado proporcional (sin texto adentro para evitar clipping)
              FractionallySizedBox(
                widthFactor: clampedRatio,
                heightFactor: 1.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: progressColor.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              // Capa 2: Contenido superior completo al 100% de ancho
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Row(
                  children: [
                    if (avatar != null) ...[
                      ClipOval(
                        child: Container(
                          width: 36,
                          height: 36,
                          color: Colors.white,
                          child: Center(child: avatar!),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                    // Título y Subtítulo
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AutoSizeText(
                            title,
                            maxLines: 1,
                            minFontSize: 11,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          AutoSizeText(
                            subtitle,
                            maxLines: 1,
                            minFontSize: 9,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Badge de porcentaje/participación de alto contraste
                    CleanSoftPill(
                      text: displayPercent,
                      backgroundColor: progressColor,
                      textColor: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

