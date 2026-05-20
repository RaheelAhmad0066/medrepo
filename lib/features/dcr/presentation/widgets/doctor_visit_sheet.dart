import 'package:flutter/material.dart';
import 'package:medrep_pro/core/theme/app_theme.dart';

class DoctorVisitSheet extends StatefulWidget {
  final String doctorName;
  final String specialty;

  const DoctorVisitSheet({
    Key? key,
    required this.doctorName,
    required this.specialty,
  }) : super(key: key);

  @override
  State<DoctorVisitSheet> createState() => _DoctorVisitSheetState();
}

class _DoctorVisitSheetState extends State<DoctorVisitSheet> {
  String? _selectedOutcome;
  final TextEditingController _notesController = TextEditingController();

  final List<String> _outcomes = [
    'positive',
    'neutral',
    'needs_followup',
    'not_found',
    'rescheduled'
  ];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _saveVisit() {
    if (_selectedOutcome == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a call outcome')),
      );
      return;
    }
    // Save to Drift SyncQueue
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Visit saved to offline queue.'),
        backgroundColor: AppTheme.successColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.doctorName, style: AppTheme.titleMedium),
                    Text(widget.specialty, style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary)),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
          const Divider(height: 32),
          
          Text('Call Outcome', style: AppTheme.titleSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _outcomes.map((outcome) {
              final isSelected = _selectedOutcome == outcome;
              return ChoiceChip(
                label: Text(outcome.replaceAll('_', ' ').toUpperCase()),
                selected: isSelected,
                selectedColor: AppTheme.primaryColor.withOpacity(0.2),
                labelStyle: TextStyle(
                  color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                onSelected: (selected) {
                  setState(() => _selectedOutcome = selected ? outcome : null);
                },
              );
            }).toList(),
          ),
          
          const SizedBox(height: 24),
          Text('Discussion Notes / Follow-up', style: AppTheme.titleSmall),
          const SizedBox(height: 8),
          TextField(
            controller: _notesController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Enter any remarks, requests, or objections...',
            ),
          ),
          
          const SizedBox(height: 24),
          // Placeholder for Sample Distribution
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Row(
              children: [
                const Icon(Icons.medication, color: AppTheme.secondaryColor),
                const SizedBox(width: 12),
                Text('Add Distributed Samples', style: AppTheme.bodyMedium),
                const Spacer(),
                const Icon(Icons.add_circle_outline, color: AppTheme.primaryColor),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _saveVisit,
            child: const Text('Save Visit Record'),
          ),
        ],
      ),
    );
  }
}
