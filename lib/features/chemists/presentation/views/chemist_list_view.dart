import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medrep_pro/features/chemists/presentation/providers/chemist_providers.dart';

class ChemistListView extends ConsumerStatefulWidget {
  const ChemistListView({super.key});

  @override
  ConsumerState<ChemistListView> createState() => _ChemistListViewState();
}

class _ChemistListViewState extends ConsumerState<ChemistListView> {
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
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(chemistListProvider.notifier).fetchChemists();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chemistListProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chemist & Pharmacies'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (val) {
                    ref.read(chemistListProvider.notifier).setSearchQuery(val);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search pharmacy by name or address...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              ref.read(chemistListProvider.notifier).setSearchQuery('');
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Priority: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        ChoiceChip(
                          label: const Text('All'),
                          selected: state.selectedPriority == null,
                          onSelected: (selected) {
                            if (selected) {
                              ref.read(chemistListProvider.notifier).setPriorityFilter(null);
                            }
                          },
                        ),
                        ...['High', 'Medium', 'Low'].map((prio) {
                          return ChoiceChip(
                            label: Text(prio),
                            selected: state.selectedPriority == prio,
                            onSelected: (selected) {
                              ref.read(chemistListProvider.notifier).setPriorityFilter(selected ? prio : null);
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
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => ref.read(chemistListProvider.notifier).fetchChemists(forceRefresh: true),
              child: state.chemists.isEmpty && !state.isLoading
                  ? const Center(
                      child: Text('No chemist profiles found.'),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: state.chemists.length + (state.isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == state.chemists.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        final chem = state.chemists[index];
                        Color tagColor;
                        switch (chem.priorityTag) {
                          case 'High':
                            tagColor = Colors.redAccent;
                          case 'Medium':
                            tagColor = Colors.amber;
                          default:
                            tagColor = Colors.green;
                        }

                        final hasBalanceWarning = chem.outstandingBalance > chem.creditLimit * 0.8;

                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    chem.name,
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: tagColor.withAlpha(40),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    chem.priorityTag,
                                    style: TextStyle(
                                      color: tagColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 6),
                                Text(chem.address),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Balance: \$${chem.outstandingBalance.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color: hasBalanceWarning ? Colors.red : Colors.grey.shade700,
                                        fontWeight: hasBalanceWarning ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      'Limit: \$${chem.creditLimit.toStringAsFixed(2)}',
                                      style: TextStyle(color: Colors.grey.shade600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => context.push('/chemist-detail', extra: chem),
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
          context.push('/chemist-form');
        },
        tooltip: 'Register Chemist',
        child: const Icon(Icons.add_business),
      ),
    );
  }
}
