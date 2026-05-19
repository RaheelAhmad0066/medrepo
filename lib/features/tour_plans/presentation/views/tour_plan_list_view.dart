import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:medrep_pro/core/di/clerk_auth_provider.dart';
import 'package:medrep_pro/features/tour_plans/domain/entities/tour_plan.dart';
import 'package:medrep_pro/features/tour_plans/presentation/providers/tour_plan_providers.dart';

class TourPlanListView extends ConsumerWidget {
  const TourPlanListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tourPlanNotifierProvider);
    final auth = ref.watch(clerkAuthProvider);
    final userRole = auth.client.user?.publicMetadata?['role'] as String? ?? 'rep';
    final repId = auth.client.user?.id ?? 'demo_rep';
    final tenantId = auth.client.user?.publicMetadata?['tenant_id'] as String? ?? 'demo_tenant';
    final isManager = userRole == 'admin' || userRole == 'manager';
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tour Plans & Schedules'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(tourPlanNotifierProvider.notifier).fetchPlans(
                  repId: isManager ? null : repId,
                  forceRefresh: true,
                ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(tourPlanNotifierProvider.notifier).fetchPlans(
              repId: isManager ? null : repId,
              forceRefresh: true,
            ),
        child: state.plans.isEmpty && !state.isLoading
            ? const Center(
                child: Text('No tour plans registered.'),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: state.plans.length,
                itemBuilder: (context, index) {
                  final plan = state.plans[index];

                  Color statusColor = Colors.grey;
                  if (plan.status == 'Approved') statusColor = Colors.green;
                  if (plan.status == 'Pending Approval') statusColor = Colors.orange;
                  if (plan.status == 'Rejected') statusColor = Colors.red;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Plan: ${plan.plannedDate.toLocal().toString().split(' ')[0]}',
                                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: statusColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: statusColor.withAlpha(80)),
                                ),
                                child: Text(
                                  plan.status,
                                  style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Stops Scheduled: ${plan.routeOptimizationOrder.length}',
                            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                          ),
                          if (plan.managerComment != null && plan.managerComment!.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Comment: ${plan.managerComment}',
                                style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (isManager && plan.status == 'Pending Approval') ...[
                                OutlinedButton(
                                  onPressed: () => _updatePlanStatus(context, ref, plan, 'Rejected'),
                                  style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                                  child: const Text('Reject'),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () => _updatePlanStatus(context, ref, plan, 'Approved'),
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                                  child: const Text('Approve'),
                                ),
                                const SizedBox(width: 8),
                              ],
                              OutlinedButton.icon(
                                icon: const Icon(Icons.edit_calendar),
                                label: const Text('Edit Stops'),
                                onPressed: () {
                                  context.push('/tour-plan-scheduler', extra: plan);
                                },
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton.icon(
                                icon: const Icon(Icons.map),
                                label: const Text('View Route'),
                                onPressed: () {
                                  context.push('/tour-plan-map', extra: plan);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: !isManager
          ? FloatingActionButton(
              onPressed: () => _createNewPlan(context, ref, repId, tenantId),
              tooltip: 'Create Weekly Plan',
              child: const Icon(Icons.add_task),
            )
          : null,
    );
  }

  void _createNewPlan(BuildContext context, WidgetRef ref, String repId, String tenantId) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (picked != null) {
      final newPlan = TourPlan(
        id: const Uuid().v4(),
        tenantId: tenantId,
        repId: repId,
        plannedDate: picked,
        routeOptimizationOrder: const [],
        status: 'Draft',
        clientCreatedAt: DateTime.now(),
        lastModifiedAt: DateTime.now(),
      );

      await ref.read(tourPlanNotifierProvider.notifier).addPlan(newPlan);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Weekly plan created! Add stops to configure routing.')),
      );
    }
  }

  void _updatePlanStatus(BuildContext context, WidgetRef ref, TourPlan plan, String newStatus) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('$newStatus Tour Plan'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Manager Comment (Optional)',
            hintText: 'Provide details or feedback...',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final updated = plan.copyWith(
                status: newStatus,
                managerComment: controller.text.trim(),
                lastModifiedAt: DateTime.now(),
              );
              ref.read(tourPlanNotifierProvider.notifier).updatePlan(updated);
              Navigator.pop(ctx);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
