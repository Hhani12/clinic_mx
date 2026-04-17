import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/config/app_config.dart';
import 'dental_3d_html.dart';
import 'dental_3d_chart_windows.dart' if (dart.library.html) 'dental_3d_chart_web.dart';

/// Interactive 3D dental chart rendered via Three.js.
///
/// On **Windows** it uses `webview_windows` (Edge WebView2) with virtual
/// host mapping so the GLB loads from a local file URL.
/// On **Web** it uses an iframe via `HtmlElementView` loading the GLB from
/// the Flutter asset server.
///
/// Provides the same callback interface as `TeethChart`.
class Dental3DChart extends StatefulWidget {
  const Dental3DChart({
    super.key,
    required this.numberingSystem,
    required this.selectedTeeth,
    required this.hoveredTooth,
    required this.toothStatuses,
    required this.procedureCounts,
    required this.onHover,
    required this.onTap,
    required this.onLongPress,
  });

  final TeethNumberingSystem numberingSystem;
  final Set<int> selectedTeeth;
  final int? hoveredTooth;
  final Map<String, String> toothStatuses;
  final Map<String, int> procedureCounts;
  final ValueChanged<int?> onHover;
  final ValueChanged<int> onTap;
  final ValueChanged<int> onLongPress;

  @override
  State<Dental3DChart> createState() => _Dental3DChartState();
}

class _Dental3DChartState extends State<Dental3DChart> {
  String? _html;
  String? _error;
  bool _isModelReady = false;

  /// Platform bridge: sends JS commands, receives messages.
  DentalPlatformBridge? _bridge;

  @override
  void initState() {
    super.initState();
    _buildHtml();
  }

  void _buildHtml() {
    try {
      // Resolve the model URL per platform (no base64 embedding).
      final modelUrl = getModelUrl();
      final html = buildDental3DHtml(modelUrl: modelUrl);
      setState(() => _html = html);
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  void _handleMessage(String raw) {
    try {
      final data = jsonDecode(raw) as Map<String, dynamic>;
      final type = data['type'] as String?;
      switch (type) {
        case 'ready':
          if (mounted) {
            setState(() => _isModelReady = true);
            _pushState();
          }
          break;
        case 'toothTap':
          final u = data['universal'] as int?;
          if (u != null) widget.onTap(u);
          break;
        case 'toothLongPress':
          final u = data['universal'] as int?;
          if (u != null) widget.onLongPress(u);
          break;
        case 'toothHover':
          widget.onHover(data['universal'] as int?);
          break;
        case 'toothHoverOut':
          widget.onHover(null);
          break;
        case 'error':
          if (mounted) {
            setState(() => _error = data['message'] as String? ?? 'Unknown error');
          }
          break;
      }
    } catch (_) {}
  }

  @override
  void didUpdateWidget(covariant Dental3DChart old) {
    super.didUpdateWidget(old);
    if (_isModelReady) {
      final changed = !setEquals(widget.selectedTeeth, old.selectedTeeth) ||
          !mapEquals(widget.toothStatuses, old.toothStatuses) ||
          !mapEquals(widget.procedureCounts, old.procedureCounts) ||
          widget.numberingSystem != old.numberingSystem;
      if (changed) _pushState();
    }
  }

  void _pushState() {
    final state = jsonEncode({
      'selectedTeeth': widget.selectedTeeth.toList(),
      'toothStatuses': widget.toothStatuses,
      'procedureCounts': widget.procedureCounts,
      'numberingSystem': widget.numberingSystem.name,
    });
    _bridge?.executeJs('window.updateDentalState($state)');
  }

  @override
  void dispose() {
    _bridge?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return _StatusBox(
        icon: Icons.error_outline,
        text: 'خطأ: $_error',
      );
    }

    if (_html == null) {
      return const _StatusBox(
        icon: Icons.hourglass_top_rounded,
        text: 'جاري تحميل المجسم ثلاثي الأبعاد...',
        showSpinner: true,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: 420,
        child: Stack(
          children: [
            // Platform-specific 3D view
            buildPlatformWebView(
              html: _html!,
              onMessage: _handleMessage,
              onBridgeReady: (bridge) => _bridge = bridge,
            ),
            // Loading overlay
            if (!_isModelReady)
              Container(
                color: const Color(0xFF0D1117).withValues(alpha: 0.7),
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        color: Color(0xFF00E5FF),
                        strokeWidth: 2,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'جاري تحميل المجسم...',
                        style: TextStyle(color: Colors.white54, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            // Instruction hint
            if (_isModelReady)
              Positioned(
                bottom: 8,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'اسحب للدوران • تمرير للتكبير • اضغط على سن للاختيار',
                      style: TextStyle(fontSize: 10, color: Colors.white54),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StatusBox extends StatelessWidget {
  const _StatusBox({required this.icon, required this.text, this.showSpinner = false});
  final IconData icon;
  final String text;
  final bool showSpinner;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showSpinner)
              const CircularProgressIndicator(
                color: Color(0xFF00E5FF),
                strokeWidth: 2,
              )
            else
              Icon(icon, color: Colors.white38, size: 40),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                text,
                style: const TextStyle(color: Colors.white54, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
