import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/glass_icon_button.dart';
import '../../domain/entities/patient.dart';

class PatientListTile extends StatelessWidget {
  const PatientListTile({
    super.key,
    required this.patient,
    this.onDelete,
    this.onAttachments,
  });

  final Patient patient;
  final VoidCallback? onDelete;
  final VoidCallback? onAttachments;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            child: Text(patient.firstName.isEmpty ? '?' : patient.firstName[0]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patient.displayName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(patient.phoneNumber),
                if (patient.fullAddress.isNotEmpty) Text(patient.fullAddress),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GlassIconButton(
            tooltip: 'Profile',
            onPressed: () {
              context.go(
                RoutePaths.patientProfile.replaceFirst(
                  ':patientId',
                  patient.id,
                ),
              );
            },
            icon: Icons.open_in_new_rounded,
          ),
          const SizedBox(width: 6),
          GlassIconButton(
            tooltip: 'Edit',
            onPressed: () {
              context.go(
                RoutePaths.patientEdit.replaceFirst(':patientId', patient.id),
              );
            },
            icon: Icons.edit_rounded,
          ),
          if (onAttachments != null) ...[
            const SizedBox(width: 6),
            GlassIconButton(
              tooltip: context.l10n.tr('attachments'),
              onPressed: onAttachments,
              icon: Icons.attach_file_rounded,
            ),
          ],
          if (onDelete != null) ...[
            const SizedBox(width: 6),
            GlassIconButton(
              tooltip: 'Delete',
              onPressed: onDelete,
              icon: Icons.delete_outline_rounded,
            ),
          ],
        ],
      ),
    );
  }
}
