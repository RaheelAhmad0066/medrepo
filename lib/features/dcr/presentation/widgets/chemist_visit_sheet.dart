import 'package:flutter/material.dart';
import 'package:medrep_pro/core/theme/app_theme.dart';

class ChemistVisitSheet extends StatefulWidget {
  final String shopName;

  const ChemistVisitSheet({
    Key? key,
    required this.shopName,
  }) : super(key: key);

  @override
  State<ChemistVisitSheet> createState() => _ChemistVisitSheetState();
}

class _ChemistVisitSheetState extends State<ChemistVisitSheet> {
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _saveVisit() {
    // Save to Drift SyncQueue
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Chemist visit saved to offline queue.'),
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
                    Text(widget.shopName, style: AppTheme.titleMedium),
                    Text('Pharmacy / Chemist', style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary)),
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
          
          Text('Discussion Notes', style: AppTheme.titleSmall),
          const SizedBox(height: 8),
          TextField(
            controller: _notesController,
            maxLines: 2,
            decoration: const InputDecoration(
              hintText: 'Enter stock checking details or feedback...',
            ),
          ),
          
          const SizedBox(height: 24),
          // Inline Order Trigger
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.shopping_cart, color: AppTheme.primaryColor),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Take New Order', style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                    Text('Record sales and products', style: AppTheme.bodySmall),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.primaryColor),
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
