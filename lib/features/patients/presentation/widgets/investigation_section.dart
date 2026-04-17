import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/date_formats.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/glass_dialog.dart';
import '../../../../core/widgets/glass_icon_button.dart';
import '../../domain/entities/investigation.dart';
import '../providers/investigation_providers.dart';

/// A section widget that displays and allows uploading patient investigations.
class InvestigationSection extends ConsumerWidget {
  const InvestigationSection({super.key, required this.patientId});

  final String patientId;

  static const _allowedExtensions = ['jpg', 'jpeg', 'png', 'pdf', 'webp'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final investigationsAsync =
        ref.watch(patientInvestigationsProvider(patientId));
    final uploadState = ref.watch(investigationUploadControllerProvider);
    final tr = context.l10n.tr;

    ref.listen(investigationUploadControllerProvider, (_, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error.toString())),
        );
      }
    });

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  tr('investigations'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              FilledButton.tonalIcon(
                onPressed:
                    uploadState.isLoading ? null : () => _pickAndUpload(context, ref),
                icon: uploadState.isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.upload_file_rounded),
                label: Text(
                  uploadState.isLoading
                      ? tr('uploading')
                      : tr('uploadInvestigation'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          investigationsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Text(error.toString()),
            data: (investigations) {
              if (investigations.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(tr('noData')),
                );
              }
              return Column(
                children: investigations.map((inv) {
                  return _InvestigationTile(
                    investigation: inv,
                    onView: () => _viewImage(inv.fileUrl),
                    onDelete: () => _confirmDelete(context, ref, inv),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  static const _contentTypes = <String, String>{
    'jpg': 'image/jpeg',
    'jpeg': 'image/jpeg',
    'png': 'image/png',
    'webp': 'image/webp',
    'pdf': 'application/pdf',
  };

  Future<void> _pickAndUpload(BuildContext context, WidgetRef ref) async {
    final tr = context.l10n.tr;

    final category = await showDialog<InvestigationCategory>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(tr('category')),
        children: InvestigationCategory.values.map((cat) {
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(ctx, cat),
            child: Text(cat.labelAr),
          );
        }).toList(),
      ),
    );
    if (category == null) return;

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: _allowedExtensions,
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;

    // Validate file size before upload (max 10MB)
    final fileSize = file.size;
    const maxFileSize = 10 * 1024 * 1024; // 10MB
    if (fileSize > maxFileSize) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr('fileTooLarge'))),
        );
      }
      return;
    }

    // On desktop, file.bytes can be null even with withData: true.
    // Fall back to reading from the file path.
    Uint8List? bytes = file.bytes;
    if (bytes == null && !kIsWeb && file.path != null) {
      try {
        bytes = await File(file.path!).readAsBytes();
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('فشل قراءة الملف: ${e.toString()}')),
          );
        }
        return;
      }
    }

    if (bytes == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr('invalidFileType'))),
        );
      }
      return;
    }

    final ext = file.extension?.toLowerCase() ?? '';
    if (!_allowedExtensions.contains(ext)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr('invalidFileType'))),
        );
      }
      return;
    }

    final contentType = _contentTypes[ext] ?? 'application/octet-stream';

    await ref.read(investigationUploadControllerProvider.notifier).upload(
          patientId: patientId,
          fileName: file.name,
          bytes: bytes,
          contentType: contentType,
          category: category,
        );

    if (!context.mounted) return;
    final state = ref.read(investigationUploadControllerProvider);
    if (state.hasError) {
      // Show the actual error message from the exception
      final errorMessage = state.error?.toString() ?? tr('uploadFailed');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr('uploadSuccess'))),
      );
    }
  }

  Future<void> _viewImage(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Investigation inv,
  ) async {
    final tr = context.l10n.tr;
    final confirmed = await GlassDialog.show<bool>(
      context: context,
      icon: Icon(
        Icons.delete_outline_rounded,
        color: Theme.of(context).colorScheme.error,
      ),
      title: Text(tr('delete')),
      content: Text('${tr('delete')} ${inv.fileName}?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(tr('cancel')),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(tr('delete')),
        ),
      ],
    );
    if (confirmed != true) return;

    await ref.read(investigationUploadControllerProvider.notifier).delete(inv);
    if (!context.mounted) return;
    final state = ref.read(investigationUploadControllerProvider);
    if (!state.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr('deletedSuccessfully'))),
      );
    }
  }
}

class _InvestigationTile extends StatelessWidget {
  const _InvestigationTile({
    required this.investigation,
    required this.onView,
    required this.onDelete,
  });

  final Investigation investigation;
  final VoidCallback onView;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final tr = context.l10n.tr;
    final textSecondary = Theme.of(context).textTheme.bodySmall?.color;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.25),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                investigation.fileUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.image_rounded,
                  color: textSecondary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  investigation.fileName,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${investigation.category.labelAr} - ${DateFormats.dayMonthYear.format(investigation.createdAt)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          GlassIconButton(
            icon: Icons.visibility_rounded,
            tooltip: tr('viewImage'),
            size: 38,
            iconSize: 18,
            onPressed: onView,
          ),
          const SizedBox(width: 6),
          GlassIconButton(
            icon: Icons.delete_outline_rounded,
            tooltip: tr('delete'),
            size: 38,
            iconSize: 18,
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
