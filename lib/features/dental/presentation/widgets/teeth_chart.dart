import 'package:flutter/material.dart';

import '../../../../core/config/app_config.dart';

/// Interactive 3D-style dental chart with anatomical tooth silhouettes,
/// status-based coloring, glow effects, and procedure count badges.
class TeethChart extends StatelessWidget {
  const TeethChart({
    super.key,
    required this.numberingSystem,
    required this.selectedTeeth,
    required this.hoveredTooth,
    required this.onHover,
    required this.onTap,
    required this.onLongPress,
    this.toothStatuses = const {},
    this.procedureCounts = const {},
  });

  final TeethNumberingSystem numberingSystem;
  final Set<int> selectedTeeth;
  final int? hoveredTooth;
  final ValueChanged<int?> onHover;
  final ValueChanged<int> onTap;
  final ValueChanged<int> onLongPress;
  final Map<String, String> toothStatuses;
  final Map<String, int> procedureCounts;

  @override
  Widget build(BuildContext context) {
    final upper = List<int>.generate(16, (i) => i + 1);
    final lower = List<int>.generate(16, (i) => i + 17);

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final toothWidth = ((maxWidth - 15 * 4) / 16).clamp(28.0, 52.0);
        final toothHeight = toothWidth * 2.4;
        final spacing = (toothWidth * 0.06).clamp(2.0, 5.0);

        return Column(
          children: [
            // Upper jaw label
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                'الفك العلوي',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.4),
                  letterSpacing: 1.2,
                ),
              ),
            ),
            _JawRow(
              teeth: upper,
              isUpper: true,
              toothWidth: toothWidth,
              toothHeight: toothHeight,
              spacing: spacing,
              numberingSystem: numberingSystem,
              selectedTeeth: selectedTeeth,
              hoveredTooth: hoveredTooth,
              toothStatuses: toothStatuses,
              procedureCounts: procedureCounts,
              onHover: onHover,
              onTap: onTap,
              onLongPress: onLongPress,
            ),
            SizedBox(height: toothHeight * 0.12),
            // Gum line
            Container(
              width: (toothWidth + spacing) * 16,
              height: 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    const Color(0xFFE8A0A0).withValues(alpha: 0.15),
                    const Color(0xFFE8A0A0).withValues(alpha: 0.3),
                    const Color(0xFFE8A0A0).withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            SizedBox(height: toothHeight * 0.12),
            _JawRow(
              teeth: lower,
              isUpper: false,
              toothWidth: toothWidth,
              toothHeight: toothHeight,
              spacing: spacing,
              numberingSystem: numberingSystem,
              selectedTeeth: selectedTeeth,
              hoveredTooth: hoveredTooth,
              toothStatuses: toothStatuses,
              procedureCounts: procedureCounts,
              onHover: onHover,
              onTap: onTap,
              onLongPress: onLongPress,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                'الفك السفلي',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.4),
                  letterSpacing: 1.2,
                ),
              ),
            ),
            // Status legend
            const SizedBox(height: 14),
            _StatusLegend(),
          ],
        );
      },
    );
  }
}

class _StatusLegend extends StatelessWidget {
  static const _items = <String, Color>{
    'سليم': Color(0xFFE0E0E0),
    'محشو': Color(0xFF4FC3F7),
    'مخلوع': Color(0xFFEF5350),
    'علاج عصب': Color(0xFFAB47BC),
    'تركيبة': Color(0xFFFFB74D),
    'تقويم': Color(0xFF7E57C2),
    'معالج': Color(0xFF66BB6A),
  };

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 4,
      alignment: WrapAlignment.center,
      children: _items.entries.map((e) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: e.value.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              e.key,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ),
          ],
        );
      }).toList(),
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
    required this.toothStatuses,
    required this.procedureCounts,
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
  final Map<String, String> toothStatuses;
  final Map<String, int> procedureCounts;
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
        final status = toothStatuses[meta.fdi] ?? 'healthy';
        final procCount = procedureCounts[meta.fdi] ?? 0;

        return _ToothWidget(
          universal: universal,
          meta: meta,
          isUpper: isUpper,
          isSelected: isSelected,
          isHovered: isHovered,
          status: status,
          procedureCount: procCount,
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
    required this.status,
    required this.procedureCount,
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
  final String status;
  final int procedureCount;
  final double width;
  final double height;
  final TeethNumberingSystem numberingSystem;
  final ValueChanged<int?> onHover;
  final ValueChanged<int> onTap;
  final ValueChanged<int> onLongPress;

  static const _statusColors = <String, Color>{
    'healthy': Color(0xFFE0E0E0),
    'filled': Color(0xFF4FC3F7),
    'extracted': Color(0xFFEF5350),
    'root_canal': Color(0xFFAB47BC),
    'crowned': Color(0xFFFFB74D),
    'braces': Color(0xFF7E57C2),
    'treated': Color(0xFF66BB6A),
    'decayed': Color(0xFFFF7043),
    'missing': Color(0xFF9E9E9E),
  };

  @override
  Widget build(BuildContext context) {
    final accentColor = isSelected
        ? const Color(0xFF00E5FF)
        : _statusColors[status] ?? const Color(0xFFE0E0E0);
    final displayNumber = numberingSystem == TeethNumberingSystem.fdi
        ? meta.fdi
        : universal.toString();
    final isExtracted = status == 'extracted' || status == 'missing';

    return MouseRegion(
      onEnter: (_) => onHover(universal),
      onExit: (_) => onHover(null),
      child: GestureDetector(
        onTap: () => onTap(universal),
        onLongPress: () => onLongPress(universal),
        child: SizedBox(
          width: width,
          height: height + 16,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Tooth body
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 16,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                  decoration: BoxDecoration(
                    boxShadow: [
                      if (isSelected)
                        BoxShadow(
                          color: accentColor.withValues(alpha: 0.5),
                          blurRadius: 18,
                          spreadRadius: 3,
                        ),
                      if (isHovered && !isSelected)
                        BoxShadow(
                          color: accentColor.withValues(alpha: 0.25),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      // 3D depth shadow
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 6,
                        offset: const Offset(2, 3),
                      ),
                    ],
                  ),
                  child: CustomPaint(
                    painter: _Tooth3DPainter(
                      toothType: meta.type,
                      isUpper: isUpper,
                      isSelected: isSelected,
                      isHovered: isHovered,
                      accentColor: accentColor,
                      status: status,
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: isUpper ? height * 0.08 : height * 0.3,
                          bottom: isUpper ? height * 0.3 : height * 0.08,
                        ),
                        child: isExtracted
                            ? Icon(
                                Icons.close_rounded,
                                size: width * 0.4,
                                color: Colors.red.withValues(alpha: 0.7),
                              )
                            : Text(
                                displayNumber,
                                style: TextStyle(
                                  fontSize: width * 0.26,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected
                                      ? Colors.white
                                      : status == 'healthy'
                                          ? Colors.white.withValues(alpha: 0.85)
                                          : accentColor,
                                  shadows: isSelected
                                      ? [
                                          Shadow(
                                            color: accentColor
                                                .withValues(alpha: 0.8),
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
              // Procedure count badge
              if (procedureCount > 0)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: accentColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: accentColor.withValues(alpha: 0.5),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '$procedureCount',
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              // Number label below tooth
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    displayNumber,
                    style: TextStyle(
                      fontSize: width * 0.2,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? accentColor
                          : Colors.white.withValues(alpha: 0.4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 3D-style tooth painter with gradient fills simulating light, shadow,
/// specular highlights, and ambient occlusion for depth.
class _Tooth3DPainter extends CustomPainter {
  _Tooth3DPainter({
    required this.toothType,
    required this.isUpper,
    required this.isSelected,
    required this.isHovered,
    required this.accentColor,
    required this.status,
  });

  final String toothType;
  final bool isUpper;
  final bool isSelected;
  final bool isHovered;
  final Color accentColor;
  final String status;

  @override
  void paint(Canvas canvas, Size size) {
    final path = _buildToothPath(size);
    final w = size.width;
    final h = size.height;

    final isExtracted = status == 'extracted' || status == 'missing';

    // 3D base shadow (ambient occlusion)
    final aoPath = path.shift(const Offset(1.5, 2));
    final aoPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    canvas.drawPath(aoPath, aoPaint);

    // Main fill with 3D gradient
    final Color topColor;
    final Color bottomColor;

    if (isSelected) {
      topColor = accentColor.withValues(alpha: 0.5);
      bottomColor = accentColor.withValues(alpha: 0.2);
    } else if (isExtracted) {
      topColor = Colors.grey.withValues(alpha: 0.15);
      bottomColor = Colors.grey.withValues(alpha: 0.08);
    } else if (status != 'healthy') {
      topColor = accentColor.withValues(alpha: 0.3);
      bottomColor = accentColor.withValues(alpha: 0.12);
    } else {
      topColor = Colors.white.withValues(alpha: 0.38);
      bottomColor = Colors.white.withValues(alpha: 0.12);
    }

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [topColor, bottomColor],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawPath(path, fillPaint);

    // Specular highlight (3D light from top-left)
    final highlightRect = Rect.fromLTWH(
      w * 0.15,
      isUpper ? h * 0.05 : h * 0.4,
      w * 0.4,
      h * 0.25,
    );
    final highlightPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.topLeft,
        radius: 1.0,
        colors: [
          Colors.white.withValues(alpha: isSelected ? 0.35 : 0.2),
          Colors.white.withValues(alpha: 0.0),
        ],
      ).createShader(highlightRect);
    canvas.save();
    canvas.clipPath(path);
    canvas.drawOval(highlightRect, highlightPaint);
    canvas.restore();

    // Border with 3D effect (lighter top-left, darker bottom-right)
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = isSelected ? 2.0 : 1.2;

    if (isSelected) {
      borderPaint.color = accentColor;
    } else if (isHovered) {
      borderPaint.color = accentColor.withValues(alpha: 0.6);
    } else if (isExtracted) {
      borderPaint.color = Colors.grey.withValues(alpha: 0.2);
    } else {
      borderPaint.color = Colors.white.withValues(alpha: 0.3);
    }
    canvas.drawPath(path, borderPaint);

    // Inner highlight (top/left edge lighter for 3D)
    final innerHighlight = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = Colors.white.withValues(alpha: isSelected ? 0.2 : 0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5);
    canvas.drawPath(path, innerHighlight);

    // Selection glow
    if (isSelected) {
      final glow = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0
        ..color = accentColor.withValues(alpha: 0.2)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
      canvas.drawPath(path, glow);
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
    final r = w * 0.18;

    if (isUpper) {
      path.moveTo(w * 0.15, r);
      path.quadraticBezierTo(w * 0.15, 0, w * 0.15 + r, 0);
      path.lineTo(w * 0.85 - r, 0);
      path.quadraticBezierTo(w * 0.85, 0, w * 0.85, r);
      path.lineTo(w * 0.85, h * 0.35);
      path.quadraticBezierTo(w * 0.82, h * 0.55, w * 0.65, h * 0.7);
      path.quadraticBezierTo(w * 0.55, h * 0.85, w * 0.5, h);
      path.quadraticBezierTo(w * 0.45, h * 0.85, w * 0.35, h * 0.7);
      path.quadraticBezierTo(w * 0.18, h * 0.55, w * 0.15, h * 0.35);
      path.close();
    } else {
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
      path.moveTo(w * 0.2, w * 0.15);
      path.quadraticBezierTo(w * 0.2, 0, w * 0.35, 0);
      path.lineTo(w * 0.45, 0);
      path.quadraticBezierTo(w * 0.5, 0, w * 0.55, 0);
      path.lineTo(w * 0.65, 0);
      path.quadraticBezierTo(w * 0.8, 0, w * 0.8, w * 0.15);
      path.lineTo(w * 0.8, h * 0.3);
      path.quadraticBezierTo(w * 0.78, h * 0.5, w * 0.62, h * 0.7);
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
      path.moveTo(w * 0.1, r);
      path.quadraticBezierTo(w * 0.1, 0, w * 0.1 + r, 0);
      path.lineTo(w * 0.35, 0);
      path.quadraticBezierTo(w * 0.4, h * 0.02, w * 0.5, 0);
      path.lineTo(w * 0.9 - r, 0);
      path.quadraticBezierTo(w * 0.9, 0, w * 0.9, r);
      path.lineTo(w * 0.9, h * 0.38);
      path.quadraticBezierTo(w * 0.85, h * 0.55, w * 0.7, h * 0.68);
      path.quadraticBezierTo(w * 0.62, h * 0.8, w * 0.58, h * 0.95);
      path.quadraticBezierTo(w * 0.55, h, w * 0.5, h * 0.95);
      path.quadraticBezierTo(w * 0.45, h, w * 0.42, h * 0.95);
      path.quadraticBezierTo(w * 0.38, h * 0.8, w * 0.3, h * 0.68);
      path.quadraticBezierTo(w * 0.15, h * 0.55, w * 0.1, h * 0.38);
      path.close();
    } else {
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
      path.moveTo(w * 0.05, r);
      path.quadraticBezierTo(w * 0.05, 0, w * 0.05 + r, 0);
      path.lineTo(w * 0.28, 0);
      path.quadraticBezierTo(w * 0.33, h * 0.025, w * 0.42, 0);
      path.quadraticBezierTo(w * 0.5, h * 0.02, w * 0.58, 0);
      path.lineTo(w * 0.95 - r, 0);
      path.quadraticBezierTo(w * 0.95, 0, w * 0.95, r);
      path.lineTo(w * 0.95, h * 0.35);
      path.quadraticBezierTo(w * 0.92, h * 0.48, w * 0.82, h * 0.58);
      path.quadraticBezierTo(w * 0.78, h * 0.72, w * 0.75, h * 0.92);
      path.quadraticBezierTo(w * 0.73, h, w * 0.7, h * 0.92);
      path.quadraticBezierTo(w * 0.62, h * 0.7, w * 0.55, h * 0.85);
      path.quadraticBezierTo(w * 0.5, h * 0.92, w * 0.45, h * 0.85);
      path.quadraticBezierTo(w * 0.38, h * 0.7, w * 0.3, h * 0.92);
      path.quadraticBezierTo(w * 0.27, h, w * 0.25, h * 0.92);
      path.quadraticBezierTo(w * 0.22, h * 0.72, w * 0.18, h * 0.58);
      path.quadraticBezierTo(w * 0.08, h * 0.48, w * 0.05, h * 0.35);
      path.close();
    } else {
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
  bool shouldRepaint(covariant _Tooth3DPainter oldDelegate) {
    return isSelected != oldDelegate.isSelected ||
        isHovered != oldDelegate.isHovered ||
        toothType != oldDelegate.toothType ||
        status != oldDelegate.status ||
        accentColor != oldDelegate.accentColor;
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
    1: '18', 2: '17', 3: '16', 4: '15',
    5: '14', 6: '13', 7: '12', 8: '11',
    9: '21', 10: '22', 11: '23', 12: '24',
    13: '25', 14: '26', 15: '27', 16: '28',
    17: '38', 18: '37', 19: '36', 20: '35',
    21: '34', 22: '33', 23: '32', 24: '31',
    25: '41', 26: '42', 27: '43', 28: '44',
    29: '45', 30: '46', 31: '47', 32: '48',
  };
}
