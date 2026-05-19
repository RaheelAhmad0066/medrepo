import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:go_router/go_router.dart';
import 'package:medrep_pro/core/di/clerk_auth_provider.dart';
import 'package:medrep_pro/features/doctors/domain/entities/doctor.dart';
import 'package:medrep_pro/features/doctors/presentation/providers/doctor_providers.dart';

class DoctorListView extends ConsumerStatefulWidget {
  const DoctorListView({super.key});

  @override
  ConsumerState<DoctorListView> createState() => _DoctorListViewState();
}

class _DoctorListViewState extends ConsumerState<DoctorListView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(doctorListProvider.notifier).fetchDoctors();
    }
  }

  void _triggerExcelImportMock() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excel HCP Import Mock'),
        content: const Text(
          'This simulates parsing an XLS/CSV file offline, validating fields, and batch importing records into your local sync engine.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final tenantId = ref
                      .read(clerkAuthProvider)
                      .client
                      .user
                      ?.publicMetadata!['tenant_id'] as String? ??
                  'demo_tenant';
              final mockDoctors = [
                Doctor(
                  id: const Uuid().v4(),
                  tenantId: tenantId,
                  name: 'Dr. Sarah Connor',
                  specialty: 'Cardiology',
                  email: 'sarah.connor@hcp.org',
                  phone: '+1415998811',
                  clinicAddress: '101 Cyberdyne Ave, Suite A',
                  tier: 'A',
                  clientCreatedAt: DateTime.now(),
                  lastModifiedAt: DateTime.now(),
                  isDeleted: false,
                ),
                Doctor(
                  id: const Uuid().v4(),
                  tenantId: tenantId,
                  name: 'Dr. Marcus Wright',
                  specialty: 'Neurology',
                  email: 'marcus.w@neurotech.com',
                  phone: '+1415332244',
                  clinicAddress: '88 Cybernetics Rd',
                  tier: 'B',
                  clientCreatedAt: DateTime.now(),
                  lastModifiedAt: DateTime.now(),
                  isDeleted: false,
                ),
              ];
              ref
                  .read(doctorListProvider.notifier)
                  .mockImportExcel(mockDoctors);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Successfully imported 2 HCPs from Excel!')),
              );
            },
            child: const Text('Simulate Import'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(doctorListProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('HCP / Doctor Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_upload),
            tooltip: 'Import Excel',
            onPressed: _triggerExcelImportMock,
          ),
        ],
      ),
      body: Column(
        children: [
          // Elegant search bar and filter controls
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (val) {
                    ref.read(doctorListProvider.notifier).setSearchQuery(val);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search doctors by name or specialty...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              ref
                                  .read(doctorListProvider.notifier)
                                  .setSearchQuery('');
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Tier filter chips
                Row(
                  children: [
                    const Text(
                      'Tiers: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        ChoiceChip(
                          label: const Text('All'),
                          selected: state.selectedTier == null,
                          onSelected: (selected) {
                            if (selected) {
                              ref
                                  .read(doctorListProvider.notifier)
                                  .setTierFilter(null);
                            }
                          },
                        ),
                        ...['A', 'B', 'C'].map((tier) {
                          return ChoiceChip(
                            label: Text('Tier $tier'),
                            selected: state.selectedTier == tier,
                            onSelected: (selected) {
                              ref
                                  .read(doctorListProvider.notifier)
                                  .setTierFilter(selected ? tier : null);
                            },
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Infinite scroll paginated doctors list
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => ref
                  .read(doctorListProvider.notifier)
                  .fetchDoctors(forceRefresh: true),
              child: state.doctors.isEmpty && !state.isLoading
                  ? const Center(
                      child: Text('No healthcare professionals found.'),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount:
                          state.doctors.length + (state.isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == state.doctors.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        final doc = state.doctors[index];
                        Color tierColor;
                        switch (doc.tier) {
                          case 'A':
                            tierColor = Colors.orangeAccent;
                          case 'B':
                            tierColor = Colors.blueAccent;
                          default:
                            tierColor = Colors.grey;
                        }

                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            leading: CircleAvatar(
                              backgroundColor: tierColor.withAlpha(50),
                              child: Text(
                                doc.tier,
                                style: TextStyle(
                                  color: tierColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(
                              doc.name,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        size: 14, color: Colors.blueGrey),
                                    const SizedBox(width: 4),
                                    Text(doc.specialty),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on,
                                        size: 14, color: Colors.redAccent),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        doc.clinicAddress,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => context.push('/doctor-detail', extra: doc),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/doctor-form');
        },
        tooltip: 'Add HCP',
        child: const Icon(Icons.add),
      ),
    );
  }
}
