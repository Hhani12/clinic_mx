import 'package:flutter/material.dart';

import '../../../../core/config/app_config.dart';

/// Interactive dental chart with anatomical tooth silhouettes, cyan neon glow,
/// and info bubbles matching the reference "Liquid Glass" design.
class TeethChart extends StatelessWidget {
  const TeethChart({
    super.key,
    required this.numberingSystem,
    required this.selectedTeeth,
    required this.hoveredTooth,
    required this.onHover,
    required this.onTap,
    required this.onLongPress,
  });

  final TeethNumberingSystem numberingSystem;
  final Set<int> selectedTeeth;
  final int? hoveredTooth;
  final ValueChanged<int?> onHover;
  final ValueChanged<int> onTap;
  final ValueChanged<int> onLongPress;

  @override
  Widget build(BuildContext context) {
    // Upper jaw: teeth 1-16 (right to left in FDI: 18-11, 21-28)
    final upper = List<int>.generate(16, (i) => i + 1);
    // Lower jaw: teeth 17-32 (right to left in FDI: 38-31, 41-48)
    final lower = List<int>.generate(16, (i) => i + 17);

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        // Scale tooth size based on available width
        final toothWidth = ((maxWidth - 15 * 4) / 16).clamp(28.0, 48.0);
        final toothHeight = toothWidth * 2.2;
        final spacing = (toothWidth * 0.08).clamp(2.0, 6.0);

        return Column(
          children: [
            // Upper jaw
            _JawRow(
              teeth: upper,
              isUpper: true,
              toothWidth: toothWidth,
              toothHeight: toothHeight,
              spacing: spacing,
              numberingSystem: numberingSystem,
              selectedTeeth: selectedTeeth,
              hoveredTooth: hoveredTooth,
              onHover: onHover,
              onTap: onTap,
              onLongPress: onLongPress,
            ),
            SizedBox(height: toothHeight * 0.15),
            // Gum line divider
            Container(
              width: (toothWidth + spacing) * 16,
              height: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.white.withValues(alpha: 0.15),
                    Colors.white.withValues(alpha: 0.3),
                    Colors.white.withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            SizedBox(height: toothHeight * 0.15),
            // Lower jaw
            _JawRow(
              teeth: lower,
              isUpper: false,
              toothWidth: toothWidth,
              toothHeight: toothHeight,
              spacing: spacing,
              numberingSystem: numberingSystem,
              selectedTeeth: selectedTeeth,
              hoveredTooth: hoveredTooth,
              onHover: onHover,
              onTap: onTap,
              onLongPress: onLongPress,
            ),
          ],
        );
      },
    );
  }
}

class _JawRow extends StatelessWidget {
  const _JawRow({
    required this.teeth,
    required this.isUpper,
    required this.toothWidth,
    required this.toothHeight,
    required this.spacing,
    required this.numberingSystem,
    required this.selectedTeeth,
    required this.hoveredTooth,
    required this.onHover,
    required this.onTap,
    required this.onLongPress,
  });

  final List<int> teeth;
  final bool isUpper;
  final double toothWidth;
  final double toothHeight;
  final double spacing;
  final TeethNumberingSystem numberingSystem;
  final Set<int> selectedTeeth;
  final int? hoveredTooth;
  final ValueChanged<int?> onHover;
  final ValueChanged<int> onTap;
  final ValueChanged<int> onLongPress;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      alignment: WrapAlignment.center,
      children: teeth.map((universal) {
        final meta = ToothMeta.of(universal);
        final isSelected = selectedTeeth.contains(universal);
        final isHovered = hoveredTooth == universal;

        return _ToothWidget(
          universal: universal,
          meta: meta,
          isUpper: isUpper,
          isSelected: isSelected,
          isHovered: isHovered,
          width: toothWidth,
          height: toothHeight,
          numberingSystem: numberingSystem,
          onHover: onHover,
          onTap: onTap,
          onLongPress: onLongPress,
        );
      }).toList(),
    );
  }
}

class _ToothWidget extends StatelessWidget {
  const _ToothWidget({
    required this.universal,
    required this.meta,
    required this.isUpper,
    required this.isSelected,
    required this.isHovered,
    required this.width,
    required this.height,
    required this.numberingSystem,
    required this.onHover,
    required this.onTap,
    required this.onLongPress,
  });

  final int universal;
  final ToothMeta meta;
  final bool isUpper;
  final bool isSelected;
  final bool isHovered;
  final double width;
  final double height;
  final TeethNumberingSystem numberingSystem;
  final ValueChanged<int?> onHover;
  final ValueChanged<int> onTap;
  final ValueChanged<int> onLongPress;

  @override
  Widget build(BuildContext context) {
    final glowColor = const Color(0xFF00E5FF);
    final displayNumber = numberingSystem == TeethNumberingSystem.fdi
        ? meta.fdi
        : universal.toString();

    return MouseRegion(
      onEnter: (_) => onHover(universal),
      onExit: (_) => onHover(null),
      child: GestureDetector(
        onTap: () => onTap(universal),
        onLongPress: () => onLongPress(universal),
        child: SizedBox(
          width: width,
          height: height,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              boxShadow: [
                if (isSelected)
                  BoxShadow(
                    color: glowColor.withValues(alpha: 0.6),
                    blurRadius: 16,
                    spreadRadius: 2,
                  ),
                if (isHovered && !isSelected)
                  BoxShadow(
                    color: glowColor.withValues(alpha: 0.25),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
              ],
            ),
            child: CustomPaint(
              painter: _ToothPainter(
                toothType: meta.type,
                isUpper: isUpper,
                isSelected: isSelected,
                isHovered: isHovered,
                glowColor: glowColor,
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: isUpper ? height * 0.12 : height * 0.35,
                    bottom: isUpper ? height * 0.35 : height * 0.12,
                  ),
                  child: Text(
                    displayNumber,
                    style: TextStyle(
                      fontSize: width * 0.28,
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.85),
                      shadows: isSelected
                          ? [
                              Shadow(
                                color: glowColor.withValues(alpha: 0.8),
                                blurRadius: 6,
                              ),
                            ]
                          : null,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Paints anatomical tooth silhouettes with gradient fills and optional glow border.
class _ToothPainter extends CustomPainter {
  _ToothPainter({
    required this.toothType,
    required this.isUpper,
    required this.isSelected,
    required this.isHovered,
    required this.glowColor,
  });

  final String toothType;
  final bool isUpper;
  final bool isSelected;
  final bool isHovered;
  final Color glowColor;

  @override
  void paint(Canvas canvas, Size size) {
    final path = _buildToothPath(size);
    final w = size.width;
    final h = size.height;

    // Fill gradient
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: isUpper ? Alignment.topCenter : Alignment.bottomCenter,
        end: isUpper ? Alignment.bottomCenter : Alignment.topCenter,
        colors: isSelected
            ? [
                const Color(0xFF00BCD4).withValues(alpha: 0.45),
                const Color(0xFF00E5FF).withValues(alpha: 0.2),
              ]
            : [
                Colors.white.withValues(alpha: 0.35),
                Colors.white.withValues(alpha: 0.12),
              ],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawPath(path, fillPaint);

    // Border
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = isSelected ? 2.0 : 1.0
      ..color = isSelected
          ? glowColor
          : isHovered
              ? glowColor.withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.3);
    canvas.drawPath(path, borderPaint);

    // Inner glow for selected
    if (isSelected) {
      final innerGlow = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0
        ..color = glowColor.withValues(alpha: 0.15)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      canvas.drawPath(path, innerGlow);
    }
  }

  Path _buildToothPath(Size size) {
    switch (toothType) {
      case 'Incisor':
        return _buildIncisorPath(size);
      case 'Canine':
        return _buildCaninePath(size);
      case 'Premolar':
        return _buildPremolarPath(size);
      case 'Molar':
        return _buildMolarPath(size);
      default:
        return _buildIncisorPath(size);
    }
  }

  Path _buildIncisorPath(Size size) {
    final w = size.width;
    final h = size.height;
    final path = Path();
    final r = w * 0.18; // corner radius

    if (isUpper) {
      // Crown at top (wider), root at bottom (narrow)
      path.moveTo(w * 0.15, r);
      path.quadraticBezierTo(w * 0.15, 0, w * 0.15 + r, 0);
      path.lineTo(w * 0.85 - r, 0);
      path.quadraticBezierTo(w * 0.85, 0, w * 0.85, r);
      // Right side tapering to root
      path.lineTo(w * 0.85, h * 0.35);
      path.quadraticBezierTo(w * 0.82, h * 0.55, w * 0.65, h * 0.7);
      path.quadraticBezierTo(w * 0.55, h * 0.85, w * 0.5, h);
      // Left side root back up
      path.quadraticBezierTo(w * 0.45, h * 0.85, w * 0.35, h * 0.7);
      path.quadraticBezierTo(w * 0.18, h * 0.55, w * 0.15, h * 0.35);
      path.close();
    } else {
      // Root at top (narrow), crown at bottom (wider)
      path.moveTo(w * 0.5, 0);
      path.quadraticBezierTo(w * 0.45, h * 0.15, w * 0.35, h * 0.3);
      path.quadraticBezierTo(w * 0.18, h * 0.45, w * 0.15, h * 0.65);
      path.lineTo(w * 0.15, h - r);
      path.quadraticBezierTo(w * 0.15, h, w * 0.15 + r, h);
      path.lineTo(w * 0.85 - r, h);
      path.quadraticBezierTo(w * 0.85, h, w * 0.85, h - r);
      path.lineTo(w * 0.85, h * 0.65);
      path.quadraticBezierTo(w * 0.82, h * 0.45, w * 0.65, h * 0.3);
      path.quadraticBezierTo(w * 0.55, h * 0.15, w * 0.5, 0);
      path.close();
    }
    return path;
  }

  Path _buildCaninePath(Size size) {
    final w = size.width;
    final h = size.height;
    final path = Path();

    if (isUpper) {
      // Pointed crown at top, long single root
      path.moveTo(w * 0.2, w * 0.15);
      path.quadraticBezierTo(w * 0.2, 0, w * 0.35, 0);
      // Crown peak
      path.lineTo(w * 0.45, 0);
      path.quadraticBezierTo(w * 0.5, 0, w * 0.55, 0);
      path.lineTo(w * 0.65, 0);
      path.quadraticBezierTo(w * 0.8, 0, w * 0.8, w * 0.15);
      // Right side to root
      path.lineTo(w * 0.8, h * 0.3);
      path.quadraticBezierTo(w * 0.78, h * 0.5, w * 0.62, h * 0.7);
      // Root tip (pointed)
      path.quadraticBezierTo(w * 0.54, h * 0.88, w * 0.5, h);
      path.quadraticBezierTo(w * 0.46, h * 0.88, w * 0.38, h * 0.7);
      path.quadraticBezierTo(w * 0.22, h * 0.5, w * 0.2, h * 0.3);
      path.close();
    } else {
      path.moveTo(w * 0.5, 0);
      path.quadraticBezierTo(w * 0.46, h * 0.12, w * 0.38, h * 0.3);
      path.quadraticBezierTo(w * 0.22, h * 0.5, w * 0.2, h * 0.7);
      path.lineTo(w * 0.2, h - w * 0.15);
      path.quadraticBezierTo(w * 0.2, h, w * 0.35, h);
      path.lineTo(w * 0.65, h);
      path.quadraticBezierTo(w * 0.8, h, w * 0.8, h - w * 0.15);
      path.lineTo(w * 0.8, h * 0.7);
      path.quadraticBezierTo(w * 0.78, h * 0.5, w * 0.62, h * 0.3);
      path.quadraticBezierTo(w * 0.54, h * 0.12, w * 0.5, 0);
      path.close();
    }
    return path;
  }

  Path _buildPremolarPath(Size size) {
    final w = size.width;
    final h = size.height;
    final path = Path();
    final r = w * 0.15;

    if (isUpper) {
      // Wider crown with two cusps at top, single root
      path.moveTo(w * 0.1, r);
      path.quadraticBezierTo(w * 0.1, 0, w * 0.1 + r, 0);
      // Two cusps suggestion at top
      path.lineTo(w * 0.35, 0);
      path.quadraticBezierTo(w * 0.4, h * 0.02, w * 0.5, 0);
      path.lineTo(w * 0.9 - r, 0);
      path.quadraticBezierTo(w * 0.9, 0, w * 0.9, r);
      // Right side
      path.lineTo(w * 0.9, h * 0.38);
      path.quadraticBezierTo(w * 0.85, h * 0.55, w * 0.7, h * 0.68);
      // Root (slightly bifurcated)
      path.quadraticBezierTo(w * 0.62, h * 0.8, w * 0.58, h * 0.95);
      path.quadraticBezierTo(w * 0.55, h, w * 0.5, h * 0.95);
      path.quadraticBezierTo(w * 0.45, h, w * 0.42, h * 0.95);
      path.quadraticBezierTo(w * 0.38, h * 0.8, w * 0.3, h * 0.68);
      path.quadraticBezierTo(w * 0.15, h * 0.55, w * 0.1, h * 0.38);
      path.close();
    } else {
      // Root at top, crown at bottom
      path.moveTo(w * 0.42, h * 0.05);
      path.quadraticBezierTo(w * 0.45, 0, w * 0.5, h * 0.05);
      path.quadraticBezierTo(w * 0.55, 0, w * 0.58, h * 0.05);
      path.quadraticBezierTo(w * 0.62, h * 0.2, w * 0.7, h * 0.32);
      path.quadraticBezierTo(w * 0.85, h * 0.45, w * 0.9, h * 0.62);
      path.lineTo(w * 0.9, h - r);
      path.quadraticBezierTo(w * 0.9, h, w * 0.9 - r, h);
      path.lineTo(w * 0.1 + r, h);
      path.quadraticBezierTo(w * 0.1, h, w * 0.1, h - r);
      path.lineTo(w * 0.1, h * 0.62);
      path.quadraticBezierTo(w * 0.15, h * 0.45, w * 0.3, h * 0.32);
      path.quadraticBezierTo(w * 0.38, h * 0.2, w * 0.42, h * 0.05);
      path.close();
    }
    return path;
  }

  Path _buildMolarPath(Size size) {
    final w = size.width;
    final h = size.height;
    final path = Path();
    final r = w * 0.14;

    if (isUpper) {
      // Wide crown, triple root
      path.moveTo(w * 0.05, r);
      path.quadraticBezierTo(w * 0.05, 0, w * 0.05 + r, 0);
      // Three cusps at top
      path.lineTo(w * 0.28, 0);
      path.quadraticBezierTo(w * 0.33, h * 0.025, w * 0.42, 0);
      path.quadraticBezierTo(w * 0.5, h * 0.02, w * 0.58, 0);
      path.lineTo(w * 0.95 - r, 0);
      path.quadraticBezierTo(w * 0.95, 0, w * 0.95, r);
      // Right side
      path.lineTo(w * 0.95, h * 0.35);
      path.quadraticBezierTo(w * 0.92, h * 0.48, w * 0.82, h * 0.58);
      // Right root
      path.quadraticBezierTo(w * 0.78, h * 0.72, w * 0.75, h * 0.92);
      path.quadraticBezierTo(w * 0.73, h, w * 0.7, h * 0.92);
      // Middle root
      path.quadraticBezierTo(w * 0.62, h * 0.7, w * 0.55, h * 0.85);
      path.quadraticBezierTo(w * 0.5, h * 0.92, w * 0.45, h * 0.85);
      path.quadraticBezierTo(w * 0.38, h * 0.7, w * 0.3, h * 0.92);
      // Left root
      path.quadraticBezierTo(w * 0.27, h, w * 0.25, h * 0.92);
      path.quadraticBezierTo(w * 0.22, h * 0.72, w * 0.18, h * 0.58);
      path.quadraticBezierTo(w * 0.08, h * 0.48, w * 0.05, h * 0.35);
      path.close();
    } else {
      // Roots at top, wide crown at bottom
      path.moveTo(w * 0.25, h * 0.08);
      path.quadraticBezierTo(w * 0.27, 0, w * 0.3, h * 0.08);
      path.quadraticBezierTo(w * 0.38, h * 0.3, w * 0.45, h * 0.15);
      path.quadraticBezierTo(w * 0.5, h * 0.08, w * 0.55, h * 0.15);
      path.quadraticBezierTo(w * 0.62, h * 0.3, w * 0.7, h * 0.08);
      path.quadraticBezierTo(w * 0.73, 0, w * 0.75, h * 0.08);
      path.quadraticBezierTo(w * 0.78, h * 0.28, w * 0.82, h * 0.42);
      path.quadraticBezierTo(w * 0.92, h * 0.52, w * 0.95, h * 0.65);
      path.lineTo(w * 0.95, h - r);
      path.quadraticBezierTo(w * 0.95, h, w * 0.95 - r, h);
      path.lineTo(w * 0.05 + r, h);
      path.quadraticBezierTo(w * 0.05, h, w * 0.05, h - r);
      path.lineTo(w * 0.05, h * 0.65);
      path.quadraticBezierTo(w * 0.08, h * 0.52, w * 0.18, h * 0.42);
      path.quadraticBezierTo(w * 0.22, h * 0.28, w * 0.25, h * 0.08);
      path.close();
    }
    return path;
  }

  @override
  bool shouldRepaint(covariant _ToothPainter oldDelegate) {
    return isSelected != oldDelegate.isSelected ||
        isHovered != oldDelegate.isHovered ||
        toothType != oldDelegate.toothType;
  }
}

/// Metadata for a single tooth, mapping Universal numbering to FDI and type info.
class ToothMeta {
  const ToothMeta({
    required this.universal,
    required this.fdi,
    required this.type,
    required this.nameAr,
    required this.nameEn,
  });

  final int universal;
  final String fdi;
  final String type;
  final String nameAr;
  final String nameEn;

  static ToothMeta of(int universal) {
    final fdi = _fdiMap[universal] ?? '00';
    final fdiSecond = int.tryParse(fdi[1]) ?? 0;
    String type;
    String nameAr;
    String nameEn;

    if (fdiSecond <= 2) {
      type = 'Incisor';
      if (fdiSecond == 1) {
        nameAr = 'قاطع مركزي';
        nameEn = 'Central Incisor';
      } else {
        nameAr = 'قاطع جانبي';
        nameEn = 'Lateral Incisor';
      }
    } else if (fdiSecond == 3) {
      type = 'Canine';
      nameAr = 'ناب';
      nameEn = 'Canine';
    } else if (fdiSecond == 4) {
      type = 'Premolar';
      nameAr = 'ضاحك أول';
      nameEn = 'First Premolar';
    } else if (fdiSecond == 5) {
      type = 'Premolar';
      nameAr = 'ضاحك ثاني';
      nameEn = 'Second Premolar';
    } else if (fdiSecond == 6) {
      type = 'Molar';
      nameAr = 'رحى أولى';
      nameEn = 'First Molar';
    } else if (fdiSecond == 7) {
      type = 'Molar';
      nameAr = 'رحى ثانية';
      nameEn = 'Second Molar';
    } else {
      type = 'Molar';
      nameAr = 'رحى ثالثة (عقل)';
      nameEn = 'Third Molar (Wisdom)';
    }

    // Add quadrant info
    final fdiFirst = int.tryParse(fdi[0]) ?? 1;
    String quadrantAr;
    switch (fdiFirst) {
      case 1:
        quadrantAr = 'علوي أيمن';
        break;
      case 2:
        quadrantAr = 'علوي أيسر';
        break;
      case 3:
        quadrantAr = 'سفلي أيسر';
        break;
      case 4:
        quadrantAr = 'سفلي أيمن';
        break;
      default:
        quadrantAr = '';
    }

    return ToothMeta(
      universal: universal,
      fdi: fdi,
      type: type,
      nameAr: '$nameAr $quadrantAr',
      nameEn: nameEn,
    );
  }

  static const Map<int, String> _fdiMap = {
    1: '18',  2: '17',  3: '16',  4: '15',
    5: '14',  6: '13',  7: '12',  8: '11',
    9: '21',  10: '22', 11: '23', 12: '24',
    13: '25', 14: '26', 15: '27', 16: '28',
    17: '38', 18: '37', 19: '36', 20: '35',
    21: '34', 22: '33', 23: '32', 24: '31',
    25: '41', 26: '42', 27: '43', 28: '44',
    29: '45', 30: '46', 31: '47', 32: '48',
  };
}
