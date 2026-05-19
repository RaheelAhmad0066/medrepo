import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medrep_pro/features/dcr/domain/entities/dcr.dart';
import 'package:medrep_pro/features/dcr/presentation/providers/dcr_providers.dart';

class DcrDailyFormView extends ConsumerStatefulWidget {
  final Dcr? initialDcr;

  const DcrDailyFormView({super.key, this.initialDcr});

  @override
  ConsumerState<DcrDailyFormView> createState() => _DcrDailyFormViewState();
}

class _DcrDailyFormViewState extends ConsumerState<DcrDailyFormView> {
  @override
  Widget build(BuildContext context) {
    // If we passed an initial DCR, we might view it read-only
    // Otherwise, we load today's DCR from provider
    final isReadOnly = widget.initialDcr != null && widget.initialDcr!.status != 'draft';
    
    final asyncDcr = widget.initialDcr != null 
        ? AsyncValue.data(widget.initialDcr) 
        : ref.watch(todayDcrProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(isReadOnly ? 'DCR Summary' : 'Today\'s DCR'),
      ),
      body: asyncDcr.when(
        data: (dcr) {
          if (dcr == null) {
            return const Center(child: Text('Could not load DCR for today.'));
          }

          final doctorVisitsAsync = ref.watch(dcrDoctorVisitsProvider(dcr.id));
          final chemistVisitsAsync = ref.watch(dcrChemistVisitsProvider(dcr.id));

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.blue.shade50,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date: ${dcr.date.toLocal().toString().split(' ')[0]}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text('Status: ${dcr.status.toUpperCase()}'),
                    if (dcr.managerComment != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('Manager Note: ${dcr.managerComment}', style: const TextStyle(color: Colors.red)),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const Text('Doctor Visits (HCPs)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    doctorVisitsAsync.when(
                      data: (visits) => visits.isEmpty
                          ? const Text('No doctor visits logged yet.')
                          : Column(
                              children: visits.map((v) => ListTile(
                                leading: const Icon(Icons.medical_services, color: Colors.blue),
                                title: Text(v.doctorId), // Mock UI for now, usually would join with Doctor table
                                subtitle: Text('Outcome: ${v.callOutcome ?? 'N/A'}'),
                                trailing: isReadOnly ? null : IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    // Handle delete
                                  },
                                ),
                              )).toList(),
                            ),
                      loading: () => const CircularProgressIndicator(),
                      error: (e, s) => Text('Error: $e'),
                    ),
                    const SizedBox(height: 24),
                    const Text('Chemist Visits', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    chemistVisitsAsync.when(
                      data: (visits) => visits.isEmpty
                          ? const Text('No chemist visits logged yet.')
                          : Column(
                              children: visits.map((v) => ListTile(
                                leading: const Icon(Icons.local_pharmacy, color: Colors.orange),
                                title: Text(v.chemistId),
                                subtitle: Text('Notes: ${v.notes ?? 'None'}'),
                                trailing: isReadOnly ? null : IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    // Handle delete
                                  },
                                ),
                              )).toList(),
                            ),
                      loading: () => const CircularProgressIndicator(),
                      error: (e, s) => Text('Error: $e'),
                    ),
                  ],
                ),
              ),
              if (!isReadOnly)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Show doctor sheet
                          },
                          icon: const Icon(Icons.medical_services),
                          label: const Text('Add HCP Visit'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Show chemist sheet
                          },
                          icon: const Icon(Icons.local_pharmacy),
                          label: const Text('Add Chemist Visit'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade100),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: isReadOnly ? null : FloatingActionButton.extended(
        onPressed: () async {
          if (asyncDcr.value != null) {
            final success = await ref.read(dcrSubmitProvider.notifier).submitDcr(asyncDcr.value!);
            if (success && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('DCR Submitted to Manager')));
              Navigator.pop(context);
            }
          }
        },
        icon: const Icon(Icons.send),
        label: const Text('Submit DCR'),
      ),
    );
  }
}
