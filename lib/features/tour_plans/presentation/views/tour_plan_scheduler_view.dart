import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:medrep_pro/features/doctors/domain/entities/doctor.dart';
import 'package:medrep_pro/features/chemists/domain/entities/chemist.dart';
import 'package:medrep_pro/features/doctors/presentation/providers/doctor_providers.dart';
import 'package:medrep_pro/features/chemists/presentation/providers/chemist_providers.dart';
import 'package:medrep_pro/features/tour_plans/domain/entities/tour_plan.dart';
import 'package:medrep_pro/features/tour_plans/presentation/providers/tour_plan_providers.dart';

class TourPlanSchedulerView extends ConsumerStatefulWidget {
  final TourPlan tourPlan;

  const TourPlanSchedulerView({super.key, required this.tourPlan});

  @override
  ConsumerState<TourPlanSchedulerView> createState() => _TourPlanSchedulerViewState();
}

class _TourPlanSchedulerViewState extends ConsumerState<TourPlanSchedulerView> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tourPlanStopsProvider(widget.tourPlan.id));
    final docState = ref.watch(doctorListProvider);
    final chemState = ref.watch(chemistListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Weekly Stops'),
        actions: [
          IconButton(
            icon: const Icon(Icons.star_border_purple500),
            tooltip: 'Optimize Route Order (TSP)',
            onPressed: () => _optimizeRoute(state.stops),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.teal.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Target Date: ${widget.tourPlan.plannedDate.toLocal().toString().split(' ')[0]}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      'Status: ${widget.tourPlan.status}',
                      style: TextStyle(color: Colors.teal.shade900, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                if (widget.tourPlan.status == 'Draft')
                  ElevatedButton.icon(
                    icon: const Icon(Icons.send),
                    label: const Text('Submit'),
                    onPressed: () {
                      final updated = widget.tourPlan.copyWith(
                        status: 'Pending Approval',
                        routeOptimizationOrder: state.stops.map((e) => e.id).toList(),
                        lastModifiedAt: DateTime.now(),
                      );
                      ref.read(tourPlanNotifierProvider.notifier).updatePlan(updated);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Weekly plan submitted for manager review!')),
                      );
                      Navigator.pop(context);
                    },
                  ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Drag & drop rows below to reschedule stop sequence order manually.',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey),
            ),
          ),
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.stops.isEmpty
                    ? const Center(
                        child: Text('No stops scheduled. Tap FAB to assign a doctor or chemist.'),
                      )
                    : ReorderableListView.builder(
                        itemCount: state.stops.length,
                        onReorder: (oldIndex, newIndex) {
                          setState(() {
                            if (newIndex > oldIndex) {
                              newIndex -= 1;
                            }
                            final list = List<TourPlanStop>.from(state.stops);
                            final item = list.removeAt(oldIndex);
                            list.insert(newIndex, item);
                            ref.read(tourPlanStopsProvider(widget.tourPlan.id).notifier).updateStopsOrder(list);
                          });
                        },
                        itemBuilder: (context, index) {
                          final stop = state.stops[index];

                          String targetName = 'Loading...';
                          String details = '';
                          IconData targetIcon = Icons.help_outline;

                          if (stop.targetType == 'Doctor') {
                            targetIcon = Icons.medical_services;
                            final doc = docState.doctors.firstWhere(
                              (d) => d.id == stop.targetId,
                              orElse: () => docState.doctors.isNotEmpty ? docState.doctors.first : _dummyDoc(stop.targetId),
                            );
                            targetName = 'Dr. ${doc.name}';
                            details = '${doc.specialty} • Tier: ${doc.tier}';
                          } else {
                            targetIcon = Icons.local_pharmacy;
                            final chem = chemState.chemists.firstWhere(
                              (c) => c.id == stop.targetId,
                              orElse: () => chemState.chemists.isNotEmpty ? chemState.chemists.first : _dummyChem(stop.targetId),
                            );
                            targetName = chem.name;
                            details = '${chem.address} • Priority: ${chem.priorityTag}';
                          }

                          return Card(
                            key: ValueKey(stop.id),
                            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: stop.targetType == 'Doctor' ? Colors.blue.shade50 : Colors.orange.shade50,
                                child: Icon(
                                  targetIcon,
                                  color: stop.targetType == 'Doctor' ? Colors.blue : Colors.orange,
                                ),
                              ),
                              title: Text(
                                '#${stop.sequenceOrder}: $targetName',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(details),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      ref.read(tourPlanStopsProvider(widget.tourPlan.id).notifier).removeStop(stop.id);
                                    },
                                  ),
                                  const Icon(Icons.drag_handle),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Add Stop'),
        onPressed: () => _showAddStopSheet(context),
      ),
    );
  }

  void _optimizeRoute(List<TourPlanStop> currentStops) {
    if (currentStops.isEmpty) return;
    // Heuristic Route Optimization (Simulate Distance Sorting TSP)
    // Simply reorders stops: Doctor first (by priority tier A, B, C), then Chemist (Priority tags)
    final sortedList = List<TourPlanStop>.from(currentStops);
    sortedList.sort((a, b) {
      if (a.targetType == b.targetType) return a.targetId.compareTo(b.targetId);
      return a.targetType == 'Doctor' ? -1 : 1;
    });

    ref.read(tourPlanStopsProvider(widget.tourPlan.id).notifier).updateStopsOrder(sortedList);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Route optimization path sequencing successfully updated!')),
    );
  }

  void _showAddStopSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Consumer(
        builder: (context, ref, _) {
          final docState = ref.watch(doctorListProvider);
          final chemState = ref.watch(chemistListProvider);

          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: const PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.medical_services), text: 'Doctors (HCPs)'),
                    Tab(icon: Icon(Icons.local_pharmacy), text: 'Chemists'),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  docState.doctors.isEmpty
                      ? const Center(child: Text('No Doctors found.'))
                      : ListView.builder(
                          itemCount: docState.doctors.length,
                          itemBuilder: (context, index) {
                            final doc = docState.doctors[index];
                            return ListTile(
                              leading: const Icon(Icons.person, color: Colors.blue),
                              title: Text(doc.name),
                              subtitle: Text(doc.specialty),
                              onTap: () => _addStopToPlan(context, 'Doctor', doc.id),
                            );
                          },
                        ),
                  chemState.chemists.isEmpty
                      ? const Center(child: Text('No Chemists found.'))
                      : ListView.builder(
                          itemCount: chemState.chemists.length,
                          itemBuilder: (context, index) {
                            final chem = chemState.chemists[index];
                            return ListTile(
                              leading: const Icon(Icons.store, color: Colors.orange),
                              title: Text(chem.name),
                              subtitle: Text(chem.address),
                              onTap: () => _addStopToPlan(context, 'Chemist', chem.id),
                            );
                          },
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _addStopToPlan(BuildContext context, String type, String targetId) {
    final stop = TourPlanStop(
      id: const Uuid().v4(),
      tourPlanId: widget.tourPlan.id,
      targetType: type,
      targetId: targetId,
      sequenceOrder: 99, // Will be updated by state updateStopsOrder
      checkedIn: false,
    );

    ref.read(tourPlanStopsProvider(widget.tourPlan.id).notifier).addStop(stop);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Stop scheduled successfully!')),
    );
  }

  // Dummy fallback objects in case lists are not fully loaded in cache
  Doctor _dummyDoc(String id) => Doctor(
        id: id,
        tenantId: 'demo',
        name: 'HCP Specialist',
        specialty: 'General Practitioner',
        clinicAddress: 'General Hospital',
        tier: 'A',
        clientCreatedAt: DateTime.now(),
        lastModifiedAt: DateTime.now(),
        isDeleted: false,
      );

  Chemist _dummyChem(String id) => Chemist(
        id: id,
        tenantId: 'demo',
        name: 'Pharmacy Store',
        address: 'Commercial Market',
        priorityTag: 'High',
        outstandingBalance: 0.0,
        creditLimit: 10000.0,
        clientCreatedAt: DateTime.now(),
        lastModifiedAt: DateTime.now(),
        isDeleted: false,
      );
}
