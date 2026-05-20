import 'package:flutter/material.dart';

class AchievementMeter extends StatelessWidget {
  final double salesAmount;
  final double targetAmount;

  const AchievementMeter({
    super.key,
    required this.salesAmount,
    required this.targetAmount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percentage = targetAmount > 0 ? (salesAmount / targetAmount) * 100 : 0.0;
    
    Color progressColor;
    if (percentage < 50) {
      progressColor = Colors.redAccent;
    } else if (percentage < 80) {
      progressColor = Colors.orangeAccent;
    } else {
      progressColor = Colors.green;
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Target Achievement',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 140,
                  height: 140,
                  child: CircularProgressIndicator(
                    value: (percentage / 100).clamp(0.0, 1.0),
                    strokeWidth: 12,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    color: progressColor,
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${percentage.toStringAsFixed(1)}%',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Achieved',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatColumn(context, 'Sales', '\$${salesAmount.toStringAsFixed(0)}'),
                _buildStatColumn(context, 'Target', '\$${targetAmount.toStringAsFixed(0)}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
