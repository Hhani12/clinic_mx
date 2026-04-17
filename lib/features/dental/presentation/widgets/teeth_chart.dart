import 'package:flutter/material.dart';

import '../../../../core/config/app_config.dart';

enum ToothShape {
  centralIncisor,
  lateralIncisor,
  canine,
  firstPremolar,
  secondPremolar,
  firstMolar,
  secondMolar,
  thirdMolar,
}

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

  static const double _spacing = 2.0;
  // Sum of widthFactors for 16 teeth (one jaw): 0.90+1.05+1.20+0.90+0.90+0.80+0.70+0.85 repeated ×2 = 14.60
  static const double _totalFactor = 14.60;

  @override
  Widget build(BuildContext context) {
    final upper = List<int>.generate(16, (i) => i + 1);
    final lower = List<int>.generate(16, (i) => i + 17);

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth - _spacing * 15;
        final baseUnit = (availableWidth / _totalFactor).clamp(18.0, 38.0);
        final toothHeight = baseUnit * 2.8;
        final gumHeight = baseUnit * 0.55;

        // Pre-compute widths for gum painter
        final upperWidths =
            upper.map((u) => baseUnit * ToothMeta.of(u).widthFactor).toList();
        final lowerWidths =
            lower.map((u) => baseUnit * ToothMeta.of(u).widthFactor).toList();

        return Column(
          children: [
            // Upper jaw label
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                'الفك العلوي',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.4),
                  letterSpacing: 1.0,
                ),
              ),
            ),
            // Upper gum band
            CustomPaint(
              size: Size(constraints.maxWidth, gumHeight),
              painter: _GumBandPainter(
                isUpper: true,
                toothWidths: upperWidths,
                spacing: _spacing,
                totalWidth: constraints.maxWidth,
              ),
            ),
            // Upper jaw teeth
            _JawRow(
              teeth: upper,
              isUpper: true,
              baseUnit: baseUnit,
              toothHeight: toothHeight,
              spacing: _spacing,
              numberingSystem: numberingSystem,
              selectedTeeth: selectedTeeth,
              hoveredTooth: hoveredTooth,
              toothStatuses: toothStatuses,
              procedureCounts: procedureCounts,
              onHover: onHover,
              onTap: onTap,
              onLongPress: onLongPress,
            ),
            // Center gap / midline
            SizedBox(height: toothHeight * 0.04),
            Container(
              width: constraints.maxWidth,
              height: 1.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    const Color(0xFFE8A0A0).withValues(alpha: 0.18),
                    const Color(0xFFE8A0A0).withValues(alpha: 0.35),
                    const Color(0xFFE8A0A0).withValues(alpha: 0.18),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            SizedBox(height: toothHeight * 0.04),
            // Lower jaw teeth
            _JawRow(
              teeth: lower,
              isUpper: false,
              baseUnit: baseUnit,
              toothHeight: toothHeight,
              spacing: _spacing,
              numberingSystem: numberingSystem,
              selectedTeeth: selectedTeeth,
              hoveredTooth: hoveredTooth,
              toothStatuses: toothStatuses,
              procedureCounts: procedureCounts,
              onHover: onHover,
              onTap: onTap,
              onLongPress: onLongPress,
            ),
            // Lower gum band
            CustomPaint(
              size: Size(constraints.maxWidth, gumHeight),
              painter: _GumBandPainter(
                isUpper: false,
                toothWidths: lowerWidths,
                spacing: _spacing,
                totalWidth: constraints.maxWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'الفك السفلي',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.4),
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _StatusLegend(),
          ],
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Gum band painter with interdental papillae
// ---------------------------------------------------------------------------
class _GumBandPainter extends CustomPainter {
  _GumBandPainter({
    required this.isUpper,
    required this.toothWidths,
    required this.spacing,
    required this.totalWidth,
  });

  final bool isUpper;
  final List<double> toothWidths;
  final double spacing;
  final double totalWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height;
    final w = size.width;

    // Compute starting x to center the teeth row
    final totalTeethWidth =
        toothWidths.fold(0.0, (a, b) => a + b) + spacing * 15;
    double startX = (w - totalTeethWidth) / 2;
    if (startX < 0) startX = 0;

    // Build papilla path
    final path = Path();
    final edgeY = isUpper ? h : 0.0; // flat edge of the gum
    final baseY = isUpper ? 0.0 : h; // the other edge (top of upper, bottom of lower)

    path.moveTo(0, baseY);
    path.lineTo(startX, baseY);

    double x = startX;
    for (int i = 0; i < toothWidths.length; i++) {
      final tw = toothWidths[i];
      // Tooth extent
      path.lineTo(x, baseY);
      path.lineTo(x, edgeY);
      path.lineTo(x + tw, edgeY);
      if (i < toothWidths.length - 1) {
        // Interdental papilla: triangular bezier dipping toward midline
        final gapCenter = x + tw + spacing / 2;
        final papillaH = isUpper ? h * 0.55 : h * 0.55;
        final papillaTip = isUpper ? papillaH : h - papillaH;
        path.lineTo(x + tw, edgeY);
        path.quadraticBezierTo(gapCenter, papillaTip, x + tw + spacing, edgeY);
        x += tw + spacing;
      } else {
        x += tw;
      }
    }
    path.lineTo(x, edgeY);
    path.lineTo(w, edgeY);
    path.lineTo(w, baseY);
    path.close();

    // Gum gradient fill
    final gumPaint = Paint()
      ..shader = LinearGradient(
        begin: isUpper ? Alignment.topCenter : Alignment.bottomCenter,
        end: isUpper ? Alignment.bottomCenter : Alignment.topCenter,
        colors: [
          const Color(0xFFD81B60).withValues(alpha: 0.55),
          const Color(0xFFF48FB1).withValues(alpha: 0.30),
          const Color(0xFFF48FB1).withValues(alpha: 0.05),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawPath(path, gumPaint);

    // Subtle highlight line at the gum margin
    final marginPaint = Paint()
      ..color = const Color(0xFFFF80AB).withValues(alpha: 0.4)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, marginPaint);
  }

  @override
  bool shouldRepaint(covariant _GumBandPainter old) =>
      isUpper != old.isUpper || toothWidths != old.toothWidths;
}

// ---------------------------------------------------------------------------
// Status legend
// ---------------------------------------------------------------------------
class _StatusLegend extends StatelessWidget {
  static const _items = <String, Color>{
    'سليم': Color(0xFFE8E4DC),
    'محشو': Color(0xFF4FC3F7),
    'مخلوع': Color(0xFFEF5350),
    'علاج عصب': Color(0xFFAB47BC),
    'تركيبة': Color(0xFFFFB74D),
    'تقويم': Color(0xFF7E57C2),
    'معالج': Color(0xFF66BB6A),
    'مسوس': Color(0xFFFF7043),
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
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                color: e.value.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(2),
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

// ---------------------------------------------------------------------------
// Jaw row
// ---------------------------------------------------------------------------
class _JawRow extends StatelessWidget {
  const _JawRow({
    required this.teeth,
    required this.isUpper,
    required this.baseUnit,
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
  final double baseUnit;
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment:
          isUpper ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: teeth.asMap().entries.map((entry) {
        final i = entry.key;
        final universal = entry.value;
        final meta = ToothMeta.of(universal);
        final toothWidth = baseUnit * meta.widthFactor;
        final isSelected = selectedTeeth.contains(universal);
        final isHovered = hoveredTooth == universal;
        final status = toothStatuses[meta.fdi] ?? 'healthy';
        final procCount = procedureCounts[meta.fdi] ?? 0;

        return Padding(
          padding: EdgeInsets.only(right: i < teeth.length - 1 ? spacing : 0),
          child: _ToothWidget(
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
          ),
        );
      }).toList(),
    );
  }
}

// ---------------------------------------------------------------------------
// Single tooth widget
// ---------------------------------------------------------------------------
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
    'healthy': Color(0xFFE8E4DC),
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
    final statusColor = _statusColors[status] ?? const Color(0xFFE8E4DC);
    final accentColor =
        isSelected ? const Color(0xFF00E5FF) : statusColor;
    final isExtracted = status == 'extracted' || status == 'missing';
    final displayNumber = numberingSystem == TeethNumberingSystem.fdi
        ? meta.fdi
        : universal.toString();

    // Label height area
    const labelH = 14.0;

    return MouseRegion(
      onEnter: (_) => onHover(universal),
      onExit: (_) => onHover(null),
      child: GestureDetector(
        onTap: () => onTap(universal),
        onLongPress: () => onLongPress(universal),
        child: SizedBox(
          width: width,
          height: height + labelH,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Tooth body (buccal 3D painter)
              Positioned(
                top: isUpper ? 0 : labelH,
                left: 0,
                right: 0,
                height: height,
                child: RepaintBoundary(
                  child: CustomPaint(
                    painter: BuccalTooth3DPainter(
                      shape: meta.shape,
                      isUpper: isUpper,
                      isSelected: isSelected,
                      isHovered: isHovered,
                      accentColor: accentColor,
                      status: status,
                      statusColor: statusColor,
                      isExtracted: isExtracted,
                    ),
                    child: isExtracted
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: isUpper ? height * 0.2 : height * 0.55,
                              ),
                              child: Icon(
                                Icons.close_rounded,
                                size: width * 0.45,
                                color: Colors.red.withValues(alpha: 0.6),
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
              ),
              // Procedure count badge
              if (procedureCount > 0)
                Positioned(
                  top: isUpper ? 0 : labelH,
                  right: 0,
                  child: Container(
                    width: 14,
                    height: 14,
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
                          fontSize: 8,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              // FDI/Universal number label
              Positioned(
                top: isUpper ? height + 1 : 0,
                left: 0,
                right: 0,
                height: labelH,
                child: Center(
                  child: Text(
                    displayNumber,
                    style: TextStyle(
                      fontSize: 8.5,
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

// ---------------------------------------------------------------------------
// Buccal 3D tooth painter — 10 rendering layers
// ---------------------------------------------------------------------------
class BuccalTooth3DPainter extends CustomPainter {
  BuccalTooth3DPainter({
    required this.shape,
    required this.isUpper,
    required this.isSelected,
    required this.isHovered,
    required this.accentColor,
    required this.status,
    required this.statusColor,
    required this.isExtracted,
  });

  final ToothShape shape;
  final bool isUpper;
  final bool isSelected;
  final bool isHovered;
  final Color accentColor;
  final String status;
  final Color statusColor;
  final bool isExtracted;

  // Crown occupies top 68% (upper jaw), root = bottom 32%
  // For lower jaw it's mirrored: root top 32%, crown bottom 68%
  static const double _crownFraction = 0.68;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final crownH = h * _crownFraction;
    final rootH = h * (1 - _crownFraction);

    // For upper: crown at top [0..crownH], root at bottom [crownH..h]
    // For lower: root at top [0..rootH], crown at bottom [rootH..h]
    final crownTop = isUpper ? 0.0 : rootH;
    final rootTop = isUpper ? crownH : 0.0;

    final crownRect = Rect.fromLTWH(0, crownTop, w, crownH);
    final rootRect = Rect.fromLTWH(0, rootTop, w, rootH);

    final crownPath = _buildCrownPath(size, crownTop, crownH);
    final rootPath = _buildRootPath(size, rootTop, rootH, crownTop, crownH);

    // ---- Layer 1: Drop shadow ----
    canvas.save();
    canvas.translate(1.5, isUpper ? 2.5 : -2.5);
    canvas.drawPath(
      crownPath,
      Paint()
        ..color = Colors.black.withValues(alpha: 0.22)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    canvas.restore();

    if (!isExtracted) {
      // ---- Layer 2: Root dentin fill ----
      canvas.save();
      canvas.clipPath(rootPath);
      canvas.drawRect(
        rootRect,
        Paint()
          ..shader = LinearGradient(
            begin: isUpper ? Alignment.topCenter : Alignment.bottomCenter,
            end: isUpper ? Alignment.bottomCenter : Alignment.topCenter,
            colors: const [
              Color(0xFFD4C4A0),
              Color(0xFFBBA882),
            ],
          ).createShader(rootRect),
      );
      canvas.restore();

      // ---- Layer 3: Crown enamel base fill ----
      canvas.save();
      canvas.clipPath(crownPath);
      canvas.drawRect(
        crownRect,
        Paint()
          ..shader = LinearGradient(
            begin: isUpper ? Alignment.topCenter : Alignment.bottomCenter,
            end: isUpper ? Alignment.bottomCenter : Alignment.topCenter,
            colors: const [
              Color(0xFFF8F6F2), // incisal/occlusal: warm white
              Color(0xFFEDE8DE), // mid-crown: cream
              Color(0xFFD8CFBA), // cervical: dentin tint
            ],
            stops: [0.0, 0.55, 1.0],
          ).createShader(crownRect),
      );
      canvas.restore();

      // ---- Layer 4: Buccal convexity diffuse lighting ----
      final diffuseCenter = Offset(w * 0.40, crownTop + crownH * 0.32);
      final diffuseRect = Rect.fromCenter(
        center: diffuseCenter,
        width: w * 0.75,
        height: crownH * 0.58,
      );
      canvas.save();
      canvas.clipPath(crownPath);
      canvas.drawOval(
        diffuseRect,
        Paint()
          ..shader = RadialGradient(
            center: const Alignment(-0.2, -0.3),
            radius: 0.85,
            colors: [
              Colors.white.withValues(alpha: 0.52),
              Colors.white.withValues(alpha: 0.0),
            ],
          ).createShader(diffuseRect),
      );
      canvas.restore();

      // ---- Layer 5: Specular highlight (sharp bright spot) ----
      final specCenter = Offset(w * 0.36, crownTop + crownH * 0.20);
      final specRect = Rect.fromCenter(
        center: specCenter,
        width: w * 0.22,
        height: crownH * 0.14,
      );
      canvas.save();
      canvas.clipPath(crownPath);
      canvas.drawOval(
        specRect,
        Paint()..color = Colors.white.withValues(alpha: 0.72),
      );
      canvas.restore();

      // ---- Layer 6: Subsurface scatter (cervical amber tinge) ----
      final cervicalFraction = isUpper ? 0.72 : 0.28;
      final cervicalY = crownTop + crownH * cervicalFraction;
      final scatterRect = isUpper
          ? Rect.fromLTRB(0, cervicalY, w, crownTop + crownH)
          : Rect.fromLTRB(0, crownTop, w, cervicalY);
      canvas.save();
      canvas.clipPath(crownPath);
      canvas.drawRect(
        scatterRect,
        Paint()..color = const Color(0xFFFFE082).withValues(alpha: 0.16),
      );
      canvas.restore();

      // ---- Layer 7: Surface anatomy lines ----
      _drawSurfaceAnatomy(canvas, size, crownTop, crownH);

      // ---- Layer 8: Status color overlay ----
      if (status != 'healthy') {
        canvas.save();
        canvas.clipPath(crownPath);
        canvas.drawRect(
          crownRect,
          Paint()..color = statusColor.withValues(alpha: 0.30),
        );
        canvas.restore();
      }
    } else {
      // Extracted: very faint outline only
      canvas.save();
      canvas.clipPath(crownPath);
      canvas.drawRect(
        crownRect,
        Paint()..color = Colors.white.withValues(alpha: 0.04),
      );
      canvas.restore();
    }

    // ---- Layer 9: Border ----
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = isSelected ? 1.8 : 1.0;
    if (isSelected) {
      borderPaint.color = accentColor;
    } else if (isHovered) {
      borderPaint.color = accentColor.withValues(alpha: 0.55);
    } else if (isExtracted) {
      borderPaint.color = Colors.white.withValues(alpha: 0.12);
    } else {
      borderPaint.color = Colors.white.withValues(alpha: 0.28);
    }
    canvas.drawPath(crownPath, borderPaint);
    if (!isExtracted) {
      canvas.drawPath(
        rootPath,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.8
          ..color = Colors.white.withValues(alpha: 0.15),
      );
    }

    // ---- Layer 10: Selection glow ----
    if (isSelected) {
      canvas.drawPath(
        crownPath,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5.0
          ..color = accentColor.withValues(alpha: 0.28)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
      );
    } else if (isHovered) {
      canvas.drawPath(
        crownPath,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0
          ..color = accentColor.withValues(alpha: 0.18)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
      );
    }
  }

  // ---- Surface anatomy detail lines ----
  void _drawSurfaceAnatomy(
      Canvas canvas, Size size, double crownTop, double crownH) {
    final w = size.width;
    final linePaint = Paint()
      ..color = Colors.brown.withValues(alpha: 0.10)
      ..strokeWidth = 0.7
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Mesiodistal line angles (subtle vertical lines on sides of all teeth)
    final leftLineX = w * 0.22;
    final rightLineX = w * 0.78;
    final lineStartY = crownTop + crownH * (isUpper ? 0.12 : 0.05);
    final lineEndY = crownTop + crownH * (isUpper ? 0.82 : 0.88);

    canvas.drawLine(
      Offset(leftLineX, lineStartY),
      Offset(leftLineX + w * 0.04, lineEndY),
      linePaint,
    );
    canvas.drawLine(
      Offset(rightLineX, lineStartY),
      Offset(rightLineX - w * 0.04, lineEndY),
      linePaint,
    );

    // Shape-specific anatomy
    switch (shape) {
      case ToothShape.firstMolar:
      case ToothShape.secondMolar:
      case ToothShape.thirdMolar:
        // Buccal groove: vertical line at center
        final grooveX = w * 0.52;
        final groovePath = Path()
          ..moveTo(grooveX, crownTop + crownH * (isUpper ? 0.08 : 0.05))
          ..quadraticBezierTo(
            grooveX + w * 0.03,
            crownTop + crownH * 0.5,
            grooveX,
            crownTop + crownH * (isUpper ? 0.88 : 0.92),
          );
        canvas.drawPath(
          groovePath,
          Paint()
            ..color = Colors.brown.withValues(alpha: 0.14)
            ..strokeWidth = 0.9
            ..style = PaintingStyle.stroke,
        );
        break;

      case ToothShape.canine:
        // Labial ridge: lighter stripe in center
        final ridgePath = Path()
          ..moveTo(w * 0.50, crownTop + crownH * (isUpper ? 0.05 : 0.02))
          ..lineTo(w * 0.50, crownTop + crownH * (isUpper ? 0.88 : 0.95));
        canvas.drawPath(
          ridgePath,
          Paint()
            ..color = Colors.white.withValues(alpha: 0.18)
            ..strokeWidth = 1.2
            ..style = PaintingStyle.stroke,
        );
        break;

      case ToothShape.firstPremolar:
      case ToothShape.secondPremolar:
        // Buccal cusp ridge
        final ridgeY = crownTop + crownH * (isUpper ? 0.82 : 0.18);
        canvas.drawLine(
          Offset(w * 0.30, ridgeY),
          Offset(w * 0.70, ridgeY),
          Paint()
            ..color = Colors.brown.withValues(alpha: 0.10)
            ..strokeWidth = 0.7
            ..style = PaintingStyle.stroke,
        );
        break;

      default:
        break;
    }
  }

  // ---- Crown path builders (buccal silhouette) ----

  Path _buildCrownPath(Size size, double crownTop, double crownH) {
    switch (shape) {
      case ToothShape.centralIncisor:
        return _centralIncisorCrown(size, crownTop, crownH);
      case ToothShape.lateralIncisor:
        return _lateralIncisorCrown(size, crownTop, crownH);
      case ToothShape.canine:
        return _canineCrown(size, crownTop, crownH);
      case ToothShape.firstPremolar:
        return _firstPremolarCrown(size, crownTop, crownH);
      case ToothShape.secondPremolar:
        return _secondPremolarCrown(size, crownTop, crownH);
      case ToothShape.firstMolar:
        return _firstMolarCrown(size, crownTop, crownH);
      case ToothShape.secondMolar:
        return _secondMolarCrown(size, crownTop, crownH);
      case ToothShape.thirdMolar:
        return _thirdMolarCrown(size, crownTop, crownH);
    }
  }

  Path _buildRootPath(Size size, double rootTop, double rootH,
      double crownTop, double crownH) {
    final w = size.width;
    // Generic tapered root form
    // Root starts at crown-root junction width and tapers
    final rootTopWidth = w * 0.72;
    final rootApexWidth = w * 0.22;
    final leftStart = (w - rootTopWidth) / 2;
    final leftEnd = (w - rootApexWidth) / 2;
    final apexY = isUpper ? rootTop + rootH : rootTop;
    final junctionY = isUpper ? rootTop : rootTop + rootH;

    final path = Path()
      ..moveTo(leftStart, junctionY)
      ..quadraticBezierTo(leftEnd - w * 0.04, (junctionY + apexY) / 2,
          leftEnd, apexY)
      ..lineTo(leftEnd + rootApexWidth, apexY)
      ..quadraticBezierTo(leftStart + rootTopWidth + w * 0.04,
          (junctionY + apexY) / 2, leftStart + rootTopWidth, junctionY)
      ..close();
    return path;
  }

  // Central incisor: broad, rectangular crown, gentle incisal convexity
  Path _centralIncisorCrown(Size size, double top, double crownH) {
    final w = size.width;
    final bottom = isUpper ? top + crownH : top + crownH;
    final incisal = isUpper ? bottom : top;
    final cervical = isUpper ? top : bottom;

    final path = Path();
    final r = w * 0.12; // corner radius

    // Cervical margin (CEJ) - curves slightly convex toward apex
    final cej = cervical;
    final lx = w * 0.10;
    final rx = w * 0.90;

    if (isUpper) {
      // Crown top = cervical (gum side), bottom = incisal
      path.moveTo(lx + r, cej);
      path.quadraticBezierTo(lx, cej, lx, cej + r);
      path.lineTo(lx, incisal - crownH * 0.08);
      // Incisal edge with 3 subtle mamelon dips
      path.quadraticBezierTo(
          w * 0.25, incisal + crownH * 0.02, w * 0.33, incisal);
      path.quadraticBezierTo(
          w * 0.42, incisal + crownH * 0.015, w * 0.50, incisal);
      path.quadraticBezierTo(
          w * 0.58, incisal + crownH * 0.015, w * 0.67, incisal);
      path.quadraticBezierTo(
          w * 0.75, incisal + crownH * 0.02, rx, incisal - crownH * 0.08);
      path.lineTo(rx, cej + r);
      path.quadraticBezierTo(rx, cej, rx - r, cej);
      path.close();
    } else {
      // Crown bottom = cervical (gum side), top = incisal
      path.moveTo(lx + r, cervical);
      path.quadraticBezierTo(lx, cervical, lx, cervical - r);
      path.lineTo(lx, incisal + crownH * 0.08);
      path.quadraticBezierTo(
          w * 0.25, incisal - crownH * 0.02, w * 0.33, incisal);
      path.quadraticBezierTo(
          w * 0.42, incisal - crownH * 0.015, w * 0.50, incisal);
      path.quadraticBezierTo(
          w * 0.58, incisal - crownH * 0.015, w * 0.67, incisal);
      path.quadraticBezierTo(
          w * 0.75, incisal - crownH * 0.02, rx, incisal + crownH * 0.08);
      path.lineTo(rx, cervical - r);
      path.quadraticBezierTo(rx, cervical, rx - r, cervical);
      path.close();
    }
    return path;
  }

  // Lateral incisor: narrower, more rounded
  Path _lateralIncisorCrown(Size size, double top, double crownH) {
    final w = size.width;
    final lx = w * 0.12;
    final rx = w * 0.88;
    final r = w * 0.14;

    final cervical = isUpper ? top : top + crownH;
    final incisal = isUpper ? top + crownH : top;

    final path = Path();
    if (isUpper) {
      path.moveTo(lx + r, cervical);
      path.quadraticBezierTo(lx, cervical, lx, cervical + r);
      path.lineTo(lx, incisal - crownH * 0.12);
      path.quadraticBezierTo(w * 0.5, incisal + crownH * 0.02, rx,
          incisal - crownH * 0.12);
      path.lineTo(rx, cervical + r);
      path.quadraticBezierTo(rx, cervical, rx - r, cervical);
      path.close();
    } else {
      path.moveTo(lx + r, cervical);
      path.quadraticBezierTo(lx, cervical, lx, cervical - r);
      path.lineTo(lx, incisal + crownH * 0.12);
      path.quadraticBezierTo(w * 0.5, incisal - crownH * 0.02, rx,
          incisal + crownH * 0.12);
      path.lineTo(rx, cervical - r);
      path.quadraticBezierTo(rx, cervical, rx - r, cervical);
      path.close();
    }
    return path;
  }

  // Canine: prominent single cusp tip, asymmetric slopes
  Path _canineCrown(Size size, double top, double crownH) {
    final w = size.width;
    final lx = w * 0.12;
    final rx = w * 0.88;
    final r = w * 0.13;

    final cervical = isUpper ? top : top + crownH;
    final incisal = isUpper ? top + crownH : top;
    final cuspTip = isUpper ? incisal : incisal;

    final path = Path();
    if (isUpper) {
      path.moveTo(lx + r, cervical);
      path.quadraticBezierTo(lx, cervical, lx, cervical + r);
      // Mesial side (left): shorter, steeper
      path.lineTo(lx, incisal - crownH * 0.28);
      path.quadraticBezierTo(w * 0.28, cuspTip - crownH * 0.04, w * 0.50,
          cuspTip); // mesial slope
      // Distal side (right): longer, gentler
      path.quadraticBezierTo(
          w * 0.70, cuspTip - crownH * 0.02, rx, incisal - crownH * 0.35);
      path.lineTo(rx, cervical + r);
      path.quadraticBezierTo(rx, cervical, rx - r, cervical);
      path.close();
    } else {
      path.moveTo(lx + r, cervical);
      path.quadraticBezierTo(lx, cervical, lx, cervical - r);
      path.lineTo(lx, incisal + crownH * 0.28);
      path.quadraticBezierTo(w * 0.28, cuspTip + crownH * 0.04, w * 0.50,
          cuspTip);
      path.quadraticBezierTo(
          w * 0.70, cuspTip + crownH * 0.02, rx, incisal + crownH * 0.35);
      path.lineTo(rx, cervical - r);
      path.quadraticBezierTo(rx, cervical, rx - r, cervical);
      path.close();
    }
    return path;
  }

  // First premolar: bifid occlusal with buccal cusp prominent
  Path _firstPremolarCrown(Size size, double top, double crownH) {
    final w = size.width;
    final lx = w * 0.08;
    final rx = w * 0.92;
    final r = w * 0.12;

    final cervical = isUpper ? top : top + crownH;
    final occlusal = isUpper ? top + crownH : top;

    final path = Path();
    if (isUpper) {
      path.moveTo(lx + r, cervical);
      path.quadraticBezierTo(lx, cervical, lx, cervical + r);
      path.lineTo(lx, occlusal - crownH * 0.18);
      // Buccal cusp tip (prominent) at ~40% from left
      path.quadraticBezierTo(
          w * 0.22, occlusal + crownH * 0.01, w * 0.40, occlusal);
      // Central groove dip
      path.quadraticBezierTo(
          w * 0.50, occlusal - crownH * 0.04, w * 0.60, occlusal - crownH * 0.02);
      // Lingual cusp (partially visible, lower)
      path.quadraticBezierTo(
          w * 0.75, occlusal - crownH * 0.03, rx, occlusal - crownH * 0.20);
      path.lineTo(rx, cervical + r);
      path.quadraticBezierTo(rx, cervical, rx - r, cervical);
      path.close();
    } else {
      path.moveTo(lx + r, cervical);
      path.quadraticBezierTo(lx, cervical, lx, cervical - r);
      path.lineTo(lx, occlusal + crownH * 0.18);
      path.quadraticBezierTo(
          w * 0.22, occlusal - crownH * 0.01, w * 0.40, occlusal);
      path.quadraticBezierTo(
          w * 0.50, occlusal + crownH * 0.04, w * 0.60, occlusal + crownH * 0.02);
      path.quadraticBezierTo(
          w * 0.75, occlusal + crownH * 0.03, rx, occlusal + crownH * 0.20);
      path.lineTo(rx, cervical - r);
      path.quadraticBezierTo(rx, cervical, rx - r, cervical);
      path.close();
    }
    return path;
  }

  // Second premolar: more symmetric two-cusp profile
  Path _secondPremolarCrown(Size size, double top, double crownH) {
    final w = size.width;
    final lx = w * 0.08;
    final rx = w * 0.92;
    final r = w * 0.12;

    final cervical = isUpper ? top : top + crownH;
    final occlusal = isUpper ? top + crownH : top;

    final path = Path();
    if (isUpper) {
      path.moveTo(lx + r, cervical);
      path.quadraticBezierTo(lx, cervical, lx, cervical + r);
      path.lineTo(lx, occlusal - crownH * 0.16);
      path.quadraticBezierTo(
          w * 0.22, occlusal + crownH * 0.01, w * 0.38, occlusal);
      path.quadraticBezierTo(
          w * 0.50, occlusal - crownH * 0.03, w * 0.62, occlusal);
      path.quadraticBezierTo(
          w * 0.78, occlusal + crownH * 0.01, rx, occlusal - crownH * 0.16);
      path.lineTo(rx, cervical + r);
      path.quadraticBezierTo(rx, cervical, rx - r, cervical);
      path.close();
    } else {
      path.moveTo(lx + r, cervical);
      path.quadraticBezierTo(lx, cervical, lx, cervical - r);
      path.lineTo(lx, occlusal + crownH * 0.16);
      path.quadraticBezierTo(
          w * 0.22, occlusal - crownH * 0.01, w * 0.38, occlusal);
      path.quadraticBezierTo(
          w * 0.50, occlusal + crownH * 0.03, w * 0.62, occlusal);
      path.quadraticBezierTo(
          w * 0.78, occlusal - crownH * 0.01, rx, occlusal + crownH * 0.16);
      path.lineTo(rx, cervical - r);
      path.quadraticBezierTo(rx, cervical, rx - r, cervical);
      path.close();
    }
    return path;
  }

  // First molar: widest, two buccal cusps with groove
  Path _firstMolarCrown(Size size, double top, double crownH) {
    final w = size.width;
    final lx = w * 0.04;
    final rx = w * 0.96;
    final r = w * 0.10;

    final cervical = isUpper ? top : top + crownH;
    final occlusal = isUpper ? top + crownH : top;

    final path = Path();
    if (isUpper) {
      path.moveTo(lx + r, cervical);
      path.quadraticBezierTo(lx, cervical, lx, cervical + r);
      path.lineTo(lx, occlusal - crownH * 0.20);
      // Mesio-buccal cusp
      path.quadraticBezierTo(
          w * 0.18, occlusal + crownH * 0.01, w * 0.36, occlusal);
      // Buccal groove dip
      path.quadraticBezierTo(
          w * 0.50, occlusal - crownH * 0.05, w * 0.56, occlusal - crownH * 0.02);
      // Disto-buccal cusp
      path.quadraticBezierTo(
          w * 0.72, occlusal + crownH * 0.01, rx, occlusal - crownH * 0.20);
      path.lineTo(rx, cervical + r);
      path.quadraticBezierTo(rx, cervical, rx - r, cervical);
      path.close();
    } else {
      path.moveTo(lx + r, cervical);
      path.quadraticBezierTo(lx, cervical, lx, cervical - r);
      path.lineTo(lx, occlusal + crownH * 0.20);
      path.quadraticBezierTo(
          w * 0.18, occlusal - crownH * 0.01, w * 0.36, occlusal);
      path.quadraticBezierTo(
          w * 0.50, occlusal + crownH * 0.05, w * 0.56, occlusal + crownH * 0.02);
      path.quadraticBezierTo(
          w * 0.72, occlusal - crownH * 0.01, rx, occlusal + crownH * 0.20);
      path.lineTo(rx, cervical - r);
      path.quadraticBezierTo(rx, cervical, rx - r, cervical);
      path.close();
    }
    return path;
  }

  // Second molar: similar to first, slightly narrower/rounder
  Path _secondMolarCrown(Size size, double top, double crownH) {
    final w = size.width;
    final lx = w * 0.05;
    final rx = w * 0.95;
    final r = w * 0.11;

    final cervical = isUpper ? top : top + crownH;
    final occlusal = isUpper ? top + crownH : top;

    final path = Path();
    if (isUpper) {
      path.moveTo(lx + r, cervical);
      path.quadraticBezierTo(lx, cervical, lx, cervical + r);
      path.lineTo(lx, occlusal - crownH * 0.18);
      path.quadraticBezierTo(
          w * 0.20, occlusal + crownH * 0.01, w * 0.38, occlusal);
      path.quadraticBezierTo(
          w * 0.50, occlusal - crownH * 0.04, w * 0.58, occlusal - crownH * 0.01);
      path.quadraticBezierTo(
          w * 0.74, occlusal + crownH * 0.01, rx, occlusal - crownH * 0.18);
      path.lineTo(rx, cervical + r);
      path.quadraticBezierTo(rx, cervical, rx - r, cervical);
      path.close();
    } else {
      path.moveTo(lx + r, cervical);
      path.quadraticBezierTo(lx, cervical, lx, cervical - r);
      path.lineTo(lx, occlusal + crownH * 0.18);
      path.quadraticBezierTo(
          w * 0.20, occlusal - crownH * 0.01, w * 0.38, occlusal);
      path.quadraticBezierTo(
          w * 0.50, occlusal + crownH * 0.04, w * 0.58, occlusal + crownH * 0.01);
      path.quadraticBezierTo(
          w * 0.74, occlusal - crownH * 0.01, rx, occlusal + crownH * 0.18);
      path.lineTo(rx, cervical - r);
      path.quadraticBezierTo(rx, cervical, rx - r, cervical);
      path.close();
    }
    return path;
  }

  // Third molar: rounded, less defined
  Path _thirdMolarCrown(Size size, double top, double crownH) {
    final w = size.width;
    final lx = w * 0.06;
    final rx = w * 0.94;
    final r = w * 0.14;

    final cervical = isUpper ? top : top + crownH;
    final occlusal = isUpper ? top + crownH : top;

    final path = Path();
    if (isUpper) {
      path.moveTo(lx + r, cervical);
      path.quadraticBezierTo(lx, cervical, lx, cervical + r);
      path.lineTo(lx, occlusal - crownH * 0.22);
      path.quadraticBezierTo(
          w * 0.28, occlusal + crownH * 0.01, w * 0.50, occlusal);
      path.quadraticBezierTo(
          w * 0.72, occlusal + crownH * 0.01, rx, occlusal - crownH * 0.22);
      path.lineTo(rx, cervical + r);
      path.quadraticBezierTo(rx, cervical, rx - r, cervical);
      path.close();
    } else {
      path.moveTo(lx + r, cervical);
      path.quadraticBezierTo(lx, cervical, lx, cervical - r);
      path.lineTo(lx, occlusal + crownH * 0.22);
      path.quadraticBezierTo(
          w * 0.28, occlusal - crownH * 0.01, w * 0.50, occlusal);
      path.quadraticBezierTo(
          w * 0.72, occlusal - crownH * 0.01, rx, occlusal + crownH * 0.22);
      path.lineTo(rx, cervical - r);
      path.quadraticBezierTo(rx, cervical, rx - r, cervical);
      path.close();
    }
    return path;
  }

  @override
  bool shouldRepaint(covariant BuccalTooth3DPainter old) {
    return shape != old.shape ||
        isUpper != old.isUpper ||
        isSelected != old.isSelected ||
        isHovered != old.isHovered ||
        status != old.status;
  }
}

// ---------------------------------------------------------------------------
// ToothMeta — mapping Universal → FDI, shape, proportions
// ---------------------------------------------------------------------------
class ToothMeta {
  const ToothMeta({
    required this.universal,
    required this.fdi,
    required this.type,
    required this.shape,
    required this.widthFactor,
    required this.nameAr,
    required this.nameEn,
  });

  final int universal;
  final String fdi;
  final String type; // kept for backward compat
  final ToothShape shape;
  final double widthFactor;
  final String nameAr;
  final String nameEn;

  bool get isUpperJaw {
    final q = int.tryParse(fdi[0]) ?? 1;
    return q == 1 || q == 2;
  }

  static ToothMeta of(int universal) {
    final fdi = _fdiMap[universal] ?? '00';
    final fdiSecond = int.tryParse(fdi.length > 1 ? fdi[1] : '1') ?? 1;
    final fdiFirst = int.tryParse(fdi[0]) ?? 1;

    final shape = _shapeFromDigit(fdiSecond);
    final widthFactor = _widthFromShape(shape);
    final type = _typeFromShape(shape);

    final nameAr = _nameArFromDigit(fdiSecond);
    final nameEn = _nameEnFromDigit(fdiSecond);

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
      shape: shape,
      widthFactor: widthFactor,
      nameAr: '$nameAr $quadrantAr',
      nameEn: nameEn,
    );
  }

  static ToothShape _shapeFromDigit(int d) {
    switch (d) {
      case 1:
        return ToothShape.centralIncisor;
      case 2:
        return ToothShape.lateralIncisor;
      case 3:
        return ToothShape.canine;
      case 4:
        return ToothShape.firstPremolar;
      case 5:
        return ToothShape.secondPremolar;
      case 6:
        return ToothShape.firstMolar;
      case 7:
        return ToothShape.secondMolar;
      default:
        return ToothShape.thirdMolar;
    }
  }

  static double _widthFromShape(ToothShape s) {
    switch (s) {
      case ToothShape.centralIncisor:
        return 0.85;
      case ToothShape.lateralIncisor:
        return 0.70;
      case ToothShape.canine:
        return 0.80;
      case ToothShape.firstPremolar:
        return 0.90;
      case ToothShape.secondPremolar:
        return 0.90;
      case ToothShape.firstMolar:
        return 1.20;
      case ToothShape.secondMolar:
        return 1.05;
      case ToothShape.thirdMolar:
        return 0.90;
    }
  }

  static String _typeFromShape(ToothShape s) {
    switch (s) {
      case ToothShape.centralIncisor:
      case ToothShape.lateralIncisor:
        return 'Incisor';
      case ToothShape.canine:
        return 'Canine';
      case ToothShape.firstPremolar:
      case ToothShape.secondPremolar:
        return 'Premolar';
      case ToothShape.firstMolar:
      case ToothShape.secondMolar:
      case ToothShape.thirdMolar:
        return 'Molar';
    }
  }

  static String _nameArFromDigit(int d) {
    switch (d) {
      case 1:
        return 'قاطع مركزي';
      case 2:
        return 'قاطع جانبي';
      case 3:
        return 'ناب';
      case 4:
        return 'ضاحك أول';
      case 5:
        return 'ضاحك ثاني';
      case 6:
        return 'رحى أولى';
      case 7:
        return 'رحى ثانية';
      default:
        return 'رحى العقل';
    }
  }

  static String _nameEnFromDigit(int d) {
    switch (d) {
      case 1:
        return 'Central Incisor';
      case 2:
        return 'Lateral Incisor';
      case 3:
        return 'Canine';
      case 4:
        return 'First Premolar';
      case 5:
        return 'Second Premolar';
      case 6:
        return 'First Molar';
      case 7:
        return 'Second Molar';
      default:
        return 'Third Molar (Wisdom)';
    }
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
