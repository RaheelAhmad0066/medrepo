import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:medrep_pro/core/di/clerk_auth_provider.dart';
import 'package:medrep_pro/features/doctors/domain/entities/doctor.dart';
import 'package:medrep_pro/features/doctors/presentation/providers/doctor_providers.dart';

class DoctorFormView extends ConsumerStatefulWidget {
  final Doctor? doctor;

  const DoctorFormView({super.key, this.doctor});

  @override
  ConsumerState<DoctorFormView> createState() => _DoctorFormViewState();
}

class _DoctorFormViewState extends ConsumerState<DoctorFormView> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late String _specialty;
  String? _email;
  String? _phone;
  late String _clinicAddress;
  late String _tier;
  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    super.initState();
    final doc = widget.doctor;
    _name = doc?.name ?? '';
    _specialty = doc?.specialty ?? '';
    _email = doc?.email;
    _phone = doc?.phone;
    _clinicAddress = doc?.clinicAddress ?? '';
    _tier = doc?.tier ?? 'C';
    _latitude = doc?.latitude;
    _longitude = doc?.longitude;
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final tenantId = ref
            .read(clerkAuthProvider)
            .client
            .user
            ?.publicMetadata!['tenant_id'] as String? ??
        'demo_tenant';

    final isEdit = widget.doctor != null;
    final doctor = Doctor(
      id: widget.doctor?.id ?? const Uuid().v4(),
      tenantId: widget.doctor?.tenantId ?? tenantId,
      name: _name,
      specialty: _specialty,
      email: _email,
      phone: _phone,
      clinicAddress: _clinicAddress,
      latitude: _latitude,
      longitude: _longitude,
      tier: _tier,
      clientCreatedAt: widget.doctor?.clientCreatedAt ?? DateTime.now(),
      lastModifiedAt: DateTime.now(),
      isDeleted: false,
    );

    if (isEdit) {
      ref.read(doctorListProvider.notifier).updateDoctor(doctor);
    } else {
      ref.read(doctorListProvider.notifier).addDoctor(doctor);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(isEdit
              ? 'HCP updated successfully!'
              : 'HCP added successfully!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.doctor != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit HCP Info' : 'Register New HCP'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              initialValue: _name,
              decoration: const InputDecoration(
                labelText: 'Full Name *',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (val) => val == null || val.trim().isEmpty
                  ? 'Please enter doctor\'s name'
                  : null,
              onSaved: (val) => _name = val!.trim(),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _specialty,
              decoration: const InputDecoration(
                labelText: 'Specialty *',
                prefixIcon: Icon(Icons.star),
              ),
              validator: (val) => val == null || val.trim().isEmpty
                  ? 'Please enter medical specialty'
                  : null,
              onSaved: (val) => _specialty = val!.trim(),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                prefixIcon: Icon(Icons.email),
              ),
              validator: (val) {
                if (val != null && val.trim().isNotEmpty) {
                  final emailRegex =
                      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(val.trim())) {
                    return 'Please enter a valid email address';
                  }
                }
                return null;
              },
              onSaved: (val) => _email =
                  val != null && val.trim().isNotEmpty ? val.trim() : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone),
              ),
              onSaved: (val) => _phone =
                  val != null && val.trim().isNotEmpty ? val.trim() : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _clinicAddress,
              decoration: const InputDecoration(
                labelText: 'Clinic Address *',
                prefixIcon: Icon(Icons.location_on),
              ),
              validator: (val) => val == null || val.trim().isEmpty
                  ? 'Please enter clinic address'
                  : null,
              onSaved: (val) => _clinicAddress = val!.trim(),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _tier,
              decoration: const InputDecoration(
                labelText: 'HCP Classification Tier',
                prefixIcon: Icon(Icons.leaderboard),
              ),
              items: ['A', 'B', 'C'].map((tier) {
                return DropdownMenuItem(
                  value: tier,
                  child: Text('Tier $tier'),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _tier = val;
                  });
                }
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                isEdit ? 'Save Changes' : 'Register Doctor',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
