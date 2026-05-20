import 'package:flutter/material.dart';

class GOLMIndicator extends StatelessWidget {
  final double mtdSales;
  final double targetSales;
  final double outstandingBalance;
  final double creditLimit;

  const GOLMIndicator({
    super.key,
    required this.mtdSales,
    required this.targetSales,
    required this.outstandingBalance,
    required this.creditLimit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.4,
      children: [
        _buildStatCard(
          context,
          'MTD Sales',
          '\$${mtdSales.toStringAsFixed(0)}',
          Icons.trending_up,
          theme.colorScheme.primary,
          'Month to Date',
        ),
        _buildStatCard(
          context,
          'Target Left',
          '\$${(targetSales - mtdSales).clamp(0.0, double.infinity).toStringAsFixed(0)}',
          Icons.flag,
          theme.colorScheme.secondary,
          'Goal target remaining',
        ),
        _buildStatCard(
          context,
          'Outstanding',
          '\$${outstandingBalance.toStringAsFixed(0)}',
          Icons.account_balance_wallet,
          Colors.orangeAccent,
          'Pending balance',
        ),
        _buildStatCard(
          context,
          'Credit Limit',
          '\$${creditLimit.toStringAsFixed(0)}',
          Icons.speed,
          Colors.green,
          'Available ceiling',
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    final theme = Theme.of(context);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.outline,
                  ),
                ),
                Icon(icon, color: color, size: 20),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.outline,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
