import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medrep_pro/features/doctors/domain/entities/doctor.dart';
import 'package:medrep_pro/features/doctors/presentation/providers/doctor_providers.dart';

class DoctorDetailView extends ConsumerWidget {
  final Doctor doctor;

  const DoctorDetailView({super.key, required this.doctor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(doctor.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/doctor-form', extra: doctor),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Delete Doctor'),
                  content: const Text(
                      'Are you sure you want to delete this healthcare professional? This deletion will sync offline.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ref
                            .read(doctorListProvider.notifier)
                            .deleteDoctor(doctor.id);
                        Navigator.pop(ctx); // Close dialog
                        Navigator.pop(context); // Go back to list
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.teal.shade100,
                      child: const Icon(Icons.person,
                          size: 40, color: Colors.teal),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor.name,
                            style: theme.textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            doctor.specialty,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.grey.shade600),
                          ),
                          const SizedBox(height: 8),
                          Chip(
                            label: Text('Tier ${doctor.tier}'),
                            backgroundColor: Colors.teal.shade50,
                            // textColor: Colors.teal,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Contact & Location Section
            Text(
              'Contact & Location',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.email, color: Colors.teal),
              title: const Text('Email'),
              subtitle: Text(doctor.email ?? 'Not provided'),
            ),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.teal),
              title: const Text('Phone'),
              subtitle: Text(doctor.phone ?? 'Not provided'),
            ),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.teal),
              title: const Text('Clinic Address'),
              subtitle: Text(doctor.clinicAddress),
            ),
            if (doctor.latitude != null && doctor.longitude != null)
              ListTile(
                leading: const Icon(Icons.map, color: Colors.teal),
                title: const Text('Coordinates'),
                subtitle:
                    Text('Lat: ${doctor.latitude}, Lon: ${doctor.longitude}'),
              ),
            const SizedBox(height: 24),
            // Mock Visit History & Prescriptions Section
            Text(
              'Recent Visit History',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    leading:
                        const Icon(Icons.check_circle, color: Colors.green),
                    title: const Text('Routine Call Log'),
                    subtitle: const Text(
                        'Discussed cardiology catalog line. Samples distributed.'),
                    trailing: Text(
                      '3 days ago',
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.check_circle, color: Colors.green),
                    title: const Text('Product Presentation'),
                    subtitle: const Text(
                        'HCP requested follow up on pricing structures.'),
                    trailing: Text(
                      '2 weeks ago',
                      style: theme.textTheme.bodySmall,
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
