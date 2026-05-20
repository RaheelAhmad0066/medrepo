import 'package:flutter/material.dart';

class PendingItemsBadge extends StatelessWidget {
  final int unsyncedCount;
  final int pendingReviewCount;

  const PendingItemsBadge({
    super.key,
    required this.unsyncedCount,
    required this.pendingReviewCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (unsyncedCount == 0 && pendingReviewCount == 0) {
      return const SizedBox.shrink();
    }

    return Card(
      color: theme.colorScheme.errorContainer.withOpacity(0.4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.colorScheme.error.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: theme.colorScheme.onErrorContainer),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (unsyncedCount > 0)
                    Text(
                      '$unsyncedCount queue items waiting to sync',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onErrorContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  if (pendingReviewCount > 0)
                    Text(
                      '$pendingReviewCount tour plan stops awaiting verification',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onErrorContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
