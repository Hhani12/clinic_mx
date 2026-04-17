import 'dart:js_interop';
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

/// Returns the GLB model URL on web.
/// Flutter web serves assets at `assets/assets/<path>` relative to the origin.
String getModelUrl() {
  final origin = web.window.location.origin;
  return '$origin/assets/assets/3d_model/humanadult_teeth.glb';
}

/// Abstract bridge for communicating with the 3D JS scene on Web.
class DentalPlatformBridge {
  DentalPlatformBridge(this._iframe);
  final web.HTMLIFrameElement _iframe;

  void executeJs(String js) {
    _iframe.contentWindow?.postMessage(
      '__exec__:$js'.toJS,
      '*'.toJS,
    );
  }

  void dispose() {}
}

/// Builds the Web iframe-based 3D viewer.
Widget buildPlatformWebView({
  required String html,
  required void Function(String message) onMessage,
  required void Function(DentalPlatformBridge bridge) onBridgeReady,
}) {
  return _WebIframeView(
    html: html,
    onMessage: onMessage,
    onBridgeReady: onBridgeReady,
  );
}

class _WebIframeView extends StatefulWidget {
  const _WebIframeView({
    required this.html,
    required this.onMessage,
    required this.onBridgeReady,
  });

  final String html;
  final void Function(String) onMessage;
  final void Function(DentalPlatformBridge) onBridgeReady;

  @override
  State<_WebIframeView> createState() => _WebIframeViewState();
}

class _WebIframeViewState extends State<_WebIframeView> {
  late final String _viewType;
  late final JSFunction _messageHandler;

  @override
  void initState() {
    super.initState();
    _viewType = 'dental-3d-${DateTime.now().millisecondsSinceEpoch}';

    // Listen for postMessage from the iframe
    _messageHandler = ((web.MessageEvent event) {
      final data = event.data;
      if (data != null) {
        final str = data.dartify();
        if (str is String && str.isNotEmpty) {
          widget.onMessage(str);
        }
      }
    }).toJS;
    web.window.addEventListener('message', _messageHandler);

    // Inject eval bridge into HTML so Flutter->JS works via postMessage
    final patchedHtml = widget.html.replaceFirst(
      '</body>',
      '''
<script>
window.addEventListener('message', function(e) {
  if (typeof e.data === 'string' && e.data.startsWith('__exec__:')) {
    try { eval(e.data.substring(9)); } catch(err) { console.error(err); }
  }
});
</script>
</body>''',
    );

    ui_web.platformViewRegistry.registerViewFactory(
      _viewType,
      (int viewId) {
        final iframe =
            web.document.createElement('iframe') as web.HTMLIFrameElement;
        iframe.style.setProperty('border', 'none');
        iframe.style.setProperty('width', '100%');
        iframe.style.setProperty('height', '100%');
        iframe.srcdoc = patchedHtml.toJS;
        iframe.allow = 'autoplay';

        final bridge = DentalPlatformBridge(iframe);
        widget.onBridgeReady(bridge);

        return iframe;
      },
    );
  }

  @override
  void dispose() {
    web.window.removeEventListener('message', _messageHandler);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: _viewType);
  }
}
