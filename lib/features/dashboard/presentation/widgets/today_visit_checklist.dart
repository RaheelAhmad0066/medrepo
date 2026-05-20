import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TodayVisitChecklist extends StatelessWidget {
  final List<Map<String, dynamic>> todayVisits;

  const TodayVisitChecklist({
    super.key,
    required this.todayVisits,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's Visit Schedule",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${todayVisits.length} visits',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (todayVisits.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 40, color: theme.colorScheme.outline),
                      const SizedBox(height: 8),
                      Text(
                        'No visits planned for today',
                        style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
                      ),
                    ],
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: todayVisits.length,
                separatorBuilder: (_, __) => Divider(color: theme.colorScheme.surfaceContainerHighest, height: 1),
                itemBuilder: (context, index) {
                  final visit = todayVisits[index];
                  final bool isDoctor = visit['type'] == 'doctor';
                  
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: isDoctor ? theme.colorScheme.primary.withOpacity(0.1) : theme.colorScheme.secondary.withOpacity(0.1),
                      child: Icon(
                        isDoctor ? Icons.person : Icons.store_mall_directory,
                        color: isDoctor ? theme.colorScheme.primary : theme.colorScheme.secondary,
                      ),
                    ),
                    title: Text(
                      visit['name'] ?? '',
                      style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      '${visit['time'] ?? 'Planned'} • ${visit['area'] ?? ''}',
                      style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                    ),
                    trailing: TextButton.icon(
                      onPressed: () {
                        context.push('/dcr-daily');
                      },
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Visit'),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
