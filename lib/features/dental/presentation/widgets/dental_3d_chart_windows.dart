import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:webview_windows/webview_windows.dart';

/// The virtual hostname that maps to the Flutter assets folder.
const _kVirtualHost = 'clinic.local';

/// Returns the GLB model URL using the virtual host.
/// On Windows, we map a virtual hostname to the flutter_assets folder
/// so WebView2 can load files directly without hitting the 2MB limit.
String getModelUrl() {
  return 'https://$_kVirtualHost/assets/3d_model/humanadult_teeth.glb';
}

/// Abstract bridge for communicating with the 3D JS scene.
class DentalPlatformBridge {
  DentalPlatformBridge(this._controller);
  final WebviewController _controller;
  StreamSubscription<dynamic>? _sub;

  void executeJs(String js) {
    _controller.executeScript(js);
  }

  void dispose() {
    _sub?.cancel();
    _controller.dispose();
  }
}

/// Builds the Windows WebView2-based 3D viewer.
Widget buildPlatformWebView({
  required String html,
  required void Function(String message) onMessage,
  required void Function(DentalPlatformBridge bridge) onBridgeReady,
}) {
  return _WindowsWebView(
    html: html,
    onMessage: onMessage,
    onBridgeReady: onBridgeReady,
  );
}

class _WindowsWebView extends StatefulWidget {
  const _WindowsWebView({
    required this.html,
    required this.onMessage,
    required this.onBridgeReady,
  });

  final String html;
  final void Function(String) onMessage;
  final void Function(DentalPlatformBridge) onBridgeReady;

  @override
  State<_WindowsWebView> createState() => _WindowsWebViewState();
}

class _WindowsWebViewState extends State<_WindowsWebView> {
  final WebviewController _controller = WebviewController();
  bool _ready = false;
  File? _tempHtmlFile;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      await _controller.initialize();

      // Map the virtual host to the flutter_assets directory so the GLB
      // file can be loaded via https://clinic.local/assets/3d_model/...
      final exeDir = File(Platform.resolvedExecutable).parent.path;
      final assetsDir = p.join(exeDir, 'data', 'flutter_assets');
      await _controller.addVirtualHostNameMapping(
        _kVirtualHost,
        assetsDir,
        WebviewHostResourceAccessKind.allow,
      );

      final bridge = DentalPlatformBridge(_controller);
      bridge._sub = _controller.webMessage.listen(
        (msg) => widget.onMessage(msg.toString()),
      );
      widget.onBridgeReady(bridge);

      // Write the HTML to a temp file and navigate to it (avoids 2MB limit).
      final tempDir = await Directory.systemTemp.createTemp('dental3d_');
      _tempHtmlFile = File(p.join(tempDir.path, 'chart.html'));
      await _tempHtmlFile!.writeAsString(widget.html);
      await _controller.loadUrl(_tempHtmlFile!.uri.toString());

      if (mounted) setState(() => _ready = true);
    } catch (e) {
      debugPrint('WebView2 init error: $e');
    }
  }

  @override
  void dispose() {
    // Clean up temp file
    _tempHtmlFile?.parent.delete(recursive: true).ignore();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) return const SizedBox.shrink();
    return Webview(_controller);
  }
}
