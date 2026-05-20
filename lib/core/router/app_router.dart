import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medrep_pro/features/auth/presentation/providers/auth_state.dart';
import 'package:medrep_pro/features/auth/presentation/providers/auth_state_notifier.dart';
import 'package:medrep_pro/features/auth/presentation/views/login_view.dart';
import 'package:medrep_pro/features/doctors/domain/entities/doctor.dart';
import 'package:medrep_pro/features/doctors/presentation/views/doctor_list_view.dart';
import 'package:medrep_pro/features/doctors/presentation/views/doctor_form_view.dart';
import 'package:medrep_pro/features/doctors/presentation/views/doctor_detail_view.dart';
import 'package:medrep_pro/features/chemists/domain/entities/chemist.dart';
import 'package:medrep_pro/features/chemists/presentation/views/chemist_list_view.dart';
import 'package:medrep_pro/features/chemists/presentation/views/chemist_form_view.dart';
import 'package:medrep_pro/features/chemists/presentation/views/chemist_detail_view.dart';

import 'package:medrep_pro/features/products/domain/entities/product.dart';
import 'package:medrep_pro/features/products/presentation/views/product_list_view.dart';
import 'package:medrep_pro/features/products/presentation/views/product_detail_view.dart';
import 'package:medrep_pro/features/products/presentation/views/product_form_view.dart';
import 'package:medrep_pro/features/products/presentation/views/pdf_visual_aid_view.dart';

import 'package:medrep_pro/features/tour_plans/domain/entities/tour_plan.dart';
import 'package:medrep_pro/features/tour_plans/presentation/views/tour_plan_list_view.dart';
import 'package:medrep_pro/features/tour_plans/presentation/views/tour_plan_scheduler_view.dart';
import 'package:medrep_pro/features/tour_plans/presentation/views/tour_plan_map_view.dart';

import 'package:medrep_pro/features/dcr/domain/entities/dcr.dart';
import 'package:medrep_pro/features/dcr/presentation/views/dcr_list_view.dart';
import 'package:medrep_pro/features/dcr/presentation/views/dcr_daily_form_view.dart';

import 'package:medrep_pro/features/dashboard/presentation/widgets/achievement_meter.dart';
import 'package:medrep_pro/features/dashboard/presentation/widgets/today_visit_checklist.dart';
import 'package:medrep_pro/features/dashboard/presentation/widgets/week_on_week_chart.dart';
import 'package:medrep_pro/features/dashboard/presentation/widgets/golm_indicator.dart';
import 'package:medrep_pro/features/dashboard/presentation/widgets/pending_items_badge.dart';
import 'package:medrep_pro/features/dashboard/presentation/widgets/quick_action_fab.dart';
import 'package:medrep_pro/features/dashboard/presentation/widgets/rep_leaderboard.dart';

/// Inactivity lock view displayed when the session times out.
class LockScreenView extends ConsumerWidget {
  const LockScreenView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authStateProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_clock_outlined,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  'Session Locked',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'For your security, your session has timed out due to inactivity.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 40),
                if (state is AuthLoading)
                  const CircularProgressIndicator()
                else ...[
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    onPressed: () {
                      ref
                          .read(authStateProvider.notifier)
                          .unlockSessionWithBiometrics();
                    },
                    icon: const Icon(Icons.fingerprint),
                    label: const Text('Unlock with Biometrics'),
                  ),
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: () {
                      ref.read(authStateProvider.notifier).logout();
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Log out & Switch User'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final userState = ref.watch(authStateProvider);
    String userName = 'Representative';
    if (userState is AuthAuthenticated) {
      userName = userState.user.name;
    }

    // Mock data for display
    final List<Map<String, dynamic>> todayVisits = [
      {'name': 'Dr. Asif Mahmood (Cardio)', 'type': 'doctor', 'time': '10:30 AM', 'area': 'Lahore Central'},
      {'name': 'Time Medicos Pharmacy', 'type': 'chemist', 'time': '12:00 PM', 'area': 'Karachi South'},
      {'name': 'Dr. Fatima Kidwai (Peds)', 'type': 'doctor', 'time': '03:15 PM', 'area': 'Karachi East'},
    ];

    final List<double> currentWeekSales = [450.0, 720.0, 310.0, 850.0, 500.0, 600.0];
    final List<double> lastWeekSales = [400.0, 500.0, 600.0, 700.0, 450.0, 500.0];

    final List<Map<String, dynamic>> leaderboardData = [
      {'name': 'Salman Khan', 'territory': 'Lahore Central', 'sales': 8500.0},
      {'name': 'Zainab Bibi', 'territory': 'Karachi South', 'sales': 6400.0},
      {'name': 'Tariq Mahmood', 'territory': 'Multan City', 'sales': 4200.0},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('MedRep Pro Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authStateProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.primaryContainer.withAlpha(40),
              theme.colorScheme.surface,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back,',
                style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey.shade600),
              ),
              Text(
                userName,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              
              // 1. Pending items alerts
              const PendingItemsBadge(
                unsyncedCount: 3,
                pendingReviewCount: 1,
              ),
              const SizedBox(height: 16),

              // 2. Goal Achievement Meter
              const AchievementMeter(
                salesAmount: 3420.0,
                targetAmount: 5000.0,
              ),
              const SizedBox(height: 16),

              // 3. GOLM Chip Indicators
              const GOLMIndicator(
                mtdSales: 3420.0,
                targetSales: 5000.0,
                outstandingBalance: 1250.0,
                creditLimit: 10000.0,
              ),
              const SizedBox(height: 16),

              // 4. Today's Visit Schedule Checklist
              TodayVisitChecklist(
                todayVisits: todayVisits,
              ),
              const SizedBox(height: 16),

              // 5. Week-on-Week Growth bar chart
              WeekOnWeekChart(
                currentWeekSales: currentWeekSales,
                lastWeekSales: lastWeekSales,
              ),
              const SizedBox(height: 16),

              // 6. Medical Reps Leaderboard rankings
              RepLeaderboard(
                leaderboardData: leaderboardData,
              ),
              const SizedBox(height: 24),

              // Quick Access Hub
              Text(
                'Navigation Shortcuts',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildDashboardCard(
                    context,
                    title: 'HCP Directory',
                    subtitle: 'Doctor targets & scheduling',
                    icon: Icons.person_search,
                    color: Colors.teal,
                    onTap: () => context.push('/doctors'),
                  ),
                  _buildDashboardCard(
                    context,
                    title: 'Chemists Ledger',
                    subtitle: 'Credits & store tracking',
                    icon: Icons.store_mall_directory,
                    color: Colors.blue,
                    onTap: () => context.push('/chemists'),
                  ),
                  _buildDashboardCard(
                    context,
                    title: 'Product Catalog',
                    subtitle: 'E-Detailing & price history',
                    icon: Icons.medication,
                    color: Colors.indigo,
                    onTap: () => context.push('/products'),
                  ),
                  _buildDashboardCard(
                    context,
                    title: 'Tour Planner',
                    subtitle: 'Optimized routing & check-ins',
                    icon: Icons.map_outlined,
                    color: Colors.purple,
                    onTap: () => context.push('/tour-plans'),
                  ),
                  _buildDashboardCard(
                    context,
                    title: 'DCR Planner',
                    subtitle: 'Submit daily logs',
                    icon: Icons.edit_calendar,
                    color: Colors.deepOrange,
                    onTap: () => context.push('/dcrs'),
                  ),
                  _buildDashboardCard(
                    context,
                    title: 'Sync Status',
                    subtitle: 'Pending offline items',
                    icon: Icons.sync,
                    color: Colors.orange,
                    onTap: () => context.push('/sync-status'),
                  ),
                ],
              ),
              const SizedBox(height: 60), // Extra space to scroll past FAB
            ],
          ),
        ),
      ),
      floatingActionButton: const QuickActionFAB(),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: color.withAlpha(40),
                child: Icon(icon, color: color),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  // Create a ValueNotifier to trigger GoRouter refreshes on AuthState changes
  final listenable = ValueNotifier<AuthState>(ref.watch(authStateProvider));
  ref.listen<AuthState>(authStateProvider, (previous, next) {
    listenable.value = next;
  });

  return GoRouter(
    initialLocation: '/',
    refreshListenable: listenable,
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      final location = state.matchedLocation;

      final isLoggingIn = location == '/login';
      final isLocked = location == '/lockscreen';

      if (authState is AuthInitial ||
          authState is AuthError ||
          authState is AuthLoading) {
        if (isLoggingIn) return null;
        return '/login';
      }

      if (authState is AuthOtpSent) {
        if (isLoggingIn) return null;
        return '/login';
      }

      if (authState is AuthSessionLocked) {
        if (isLocked) return null;
        return '/lockscreen';
      }

      if (authState is AuthAuthenticated) {
        // Redirection out of entry screens
        if (isLoggingIn || isLocked) return '/';

        // Role guards
        final user = authState.user;
        if (location.startsWith('/admin') && user.role != 'admin') {
          return '/'; // Redirect non-admins to home
        }
        if (location.startsWith('/manager') &&
            user.role != 'admin' &&
            user.role != 'manager') {
          return '/'; // Redirect reps to home
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/lockscreen',
        builder: (context, state) => const LockScreenView(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const DashboardView(),
      ),
      GoRoute(
        path: '/doctors',
        builder: (context, state) => const DoctorListView(),
      ),
      GoRoute(
        path: '/doctor-form',
        builder: (context, state) => DoctorFormView(doctor: state.extra as Doctor?),
      ),
      GoRoute(
        path: '/doctor-detail',
        builder: (context, state) => DoctorDetailView(doctor: state.extra as Doctor),
      ),
      GoRoute(
        path: '/chemists',
        builder: (context, state) => const ChemistListView(),
      ),
      GoRoute(
        path: '/chemist-form',
        builder: (context, state) => ChemistFormView(chemist: state.extra as Chemist?),
      ),
      GoRoute(
        path: '/chemist-detail',
        builder: (context, state) => ChemistDetailView(chemist: state.extra as Chemist),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Admin Console')),
        ),
      ),
      GoRoute(
        path: '/manager',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Manager Dashboard')),
        ),
      ),
      GoRoute(
        path: '/sync-status',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Sync Queue Status Screen')),
        ),
      ),
      GoRoute(
        path: '/dcrs',
        builder: (context, state) => const DcrListView(),
      ),
      GoRoute(
        path: '/dcr-daily',
        builder: (context, state) => DcrDailyFormView(initialDcr: state.extra as Dcr?),
      ),
      GoRoute(
        path: '/products',
        builder: (context, state) => const ProductListView(),
      ),
      GoRoute(
        path: '/product-form',
        builder: (context, state) => ProductFormView(product: state.extra as Product?),
      ),
      GoRoute(
        path: '/product-detail',
        builder: (context, state) => ProductDetailView(product: state.extra as Product),
      ),
      GoRoute(
        path: '/pdf-visual-aid',
        builder: (context, state) => PdfVisualAidView(product: state.extra as Product),
      ),
      GoRoute(
        path: '/tour-plans',
        builder: (context, state) => const TourPlanListView(),
      ),
      GoRoute(
        path: '/tour-plan-scheduler',
        builder: (context, state) => TourPlanSchedulerView(tourPlan: state.extra as TourPlan),
      ),
      GoRoute(
        path: '/tour-plan-map',
        builder: (context, state) => TourPlanMapView(tourPlan: state.extra as TourPlan),
      ),
    ],
  );
});
