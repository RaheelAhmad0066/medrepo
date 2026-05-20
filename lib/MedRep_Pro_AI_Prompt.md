# MedRep Pro — Complete AI Development Prompt
### Flutter + Riverpod + Supabase + Clerk
---

## CONTEXT & OVERVIEW

You are building **MedRep Pro** — a mobile-first sales management platform for pharmaceutical field teams (medical reps and their managers). This app completely replaces manual Excel-based workflows with a smart mobile app.

**Tech Stack (STRICT — do not deviate):**
- **Frontend:** Flutter (latest stable)
- **State Management:** Riverpod (flutter_riverpod + riverpod_annotation + riverpod_generator)
- **Backend/Database:** Supabase (PostgreSQL + Realtime + Storage + Edge Functions)
- **Authentication:** Clerk (clerk_flutter SDK)
- **Local Storage (Offline):** Drift (SQLite ORM for Flutter)
- **PDF Generation:** pdf package (dart)
- **Excel Export:** excel package (dart)
- **Navigation:** go_router
- **AI Bot:** Anthropic Claude API (via Supabase Edge Function)
- **Push Notifications:** Firebase Cloud Messaging (FCM)
- **Maps/GPS:** google_maps_flutter + geolocator
- **Voice Input:** speech_to_text package
- **File Sharing:** share_plus package

---

## USER ROLES

There are 3 roles — every screen and data query must respect this:

| Role | Access Level |
|------|-------------|
| `medical_rep` | Own data only — own territory, own DCRs, own orders, own targets |
| `manager` | All reps under their hierarchy — full read, approve/reject actions |
| `admin` | Full system — user management, product catalog, territory config |

Store role in Clerk's `publicMetadata.role` and mirror in Supabase `profiles` table. Apply **Row Level Security (RLS)** on every Supabase table.

---

## DATABASE SCHEMA (Supabase / PostgreSQL)

Create the following tables with RLS enabled:

```sql
-- PROFILES (mirrors Clerk users)
profiles (
  id uuid PRIMARY KEY references auth.users,
  clerk_user_id text UNIQUE NOT NULL,
  full_name text,
  phone text,
  role text CHECK (role IN ('admin','manager','medical_rep')),
  territory_id uuid references territories(id),
  manager_id uuid references profiles(id),
  is_active boolean DEFAULT true,
  created_at timestamptz DEFAULT now()
)

-- TERRITORIES
territories (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  region text,
  created_at timestamptz DEFAULT now()
)

-- DOCTORS (HCP Master)
doctors (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  specialty text,
  clinic_name text,
  area text,
  city text,
  phone text,
  email text,
  tier text CHECK (tier IN ('A','B','C')),
  preferred_visit_time text,
  notes text,
  territory_id uuid references territories(id),
  created_by uuid references profiles(id),
  lat double precision,
  lng double precision,
  created_at timestamptz DEFAULT now()
)

-- CHEMISTS
chemists (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  shop_name text NOT NULL,
  owner_name text,
  area text,
  city text,
  phone text,
  credit_limit numeric DEFAULT 0,
  outstanding_balance numeric DEFAULT 0,
  priority text CHECK (priority IN ('high','regular','occasional')),
  territory_id uuid references territories(id),
  created_by uuid references profiles(id),
  lat double precision,
  lng double precision,
  last_visited_at timestamptz,
  created_at timestamptz DEFAULT now()
)

-- PRODUCTS
products (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  sku text UNIQUE,
  formulation text, -- tablet, injection, syrup
  category text,
  net_price numeric NOT NULL,
  pack_size text,
  is_sample_eligible boolean DEFAULT false,
  is_active boolean DEFAULT true,
  visual_aid_url text, -- Supabase Storage URL
  created_at timestamptz DEFAULT now()
)

-- PRODUCT PRICE HISTORY
product_price_history (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id uuid references products(id),
  old_price numeric,
  new_price numeric,
  effective_from timestamptz,
  effective_to timestamptz,
  changed_by uuid references profiles(id)
)

-- TOUR PLANS
tour_plans (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  rep_id uuid references profiles(id),
  week_start_date date NOT NULL,
  status text CHECK (status IN ('draft','submitted','approved','returned')),
  manager_note text,
  submitted_at timestamptz,
  approved_at timestamptz,
  created_at timestamptz DEFAULT now()
)

-- TOUR PLAN ENTRIES
tour_plan_entries (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tour_plan_id uuid references tour_plans(id),
  day_of_week text CHECK (day_of_week IN ('monday','tuesday','wednesday','thursday','friday','saturday')),
  session text CHECK (session IN ('morning','evening')),
  entity_type text CHECK (entity_type IN ('doctor','chemist')),
  entity_id uuid, -- references doctors or chemists
  order_index int DEFAULT 0
)

-- DCR (Daily Call Reports)
dcrs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  rep_id uuid references profiles(id),
  date date NOT NULL,
  status text CHECK (status IN ('draft','submitted','acknowledged')),
  manager_comment text,
  voice_memo_url text,
  submitted_at timestamptz,
  created_at timestamptz DEFAULT now()
)

-- DCR VISITS (Doctor)
dcr_doctor_visits (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  dcr_id uuid references dcrs(id),
  doctor_id uuid references doctors(id),
  session text CHECK (session IN ('morning','evening')),
  visit_time timestamptz,
  call_outcome text CHECK (call_outcome IN ('positive','neutral','needs_followup','not_found','rescheduled')),
  notes text,
  gps_lat double precision,
  gps_lng double precision,
  photo_url text,
  is_planned boolean DEFAULT true,
  created_at timestamptz DEFAULT now()
)

-- DCR VISIT PRODUCTS DETAILED
dcr_visit_products (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  visit_id uuid references dcr_doctor_visits(id),
  product_id uuid references products(id)
)

-- DCR CHEMIST VISITS
dcr_chemist_visits (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  dcr_id uuid references dcrs(id),
  chemist_id uuid references chemists(id),
  session text CHECK (session IN ('morning','evening')),
  visit_time timestamptz,
  notes text,
  gps_lat double precision,
  gps_lng double precision,
  photo_url text,
  is_planned boolean DEFAULT true,
  created_at timestamptz DEFAULT now()
)

-- ORDERS
orders (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  rep_id uuid references profiles(id),
  chemist_id uuid references chemists(id),
  dcr_chemist_visit_id uuid references dcr_chemist_visits(id),
  order_date date NOT NULL,
  status text CHECK (status IN ('draft','submitted','confirmed','dispatched','delivered','paid')),
  total_amount numeric DEFAULT 0,
  invoice_number text,
  manager_note text,
  created_at timestamptz DEFAULT now()
)

-- ORDER ITEMS
order_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  order_id uuid references orders(id),
  product_id uuid references products(id),
  quantity int NOT NULL,
  unit_price numeric NOT NULL,
  subtotal numeric GENERATED ALWAYS AS (quantity * unit_price) STORED
)

-- TARGETS
targets (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  rep_id uuid references profiles(id),
  product_id uuid references products(id),
  month date NOT NULL, -- first day of month
  monthly_target numeric NOT NULL,
  set_by uuid references profiles(id),
  created_at timestamptz DEFAULT now(),
  UNIQUE(rep_id, product_id, month)
)

-- SAMPLES
sample_inventory (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  rep_id uuid references profiles(id),
  product_id uuid references products(id),
  opening_balance int DEFAULT 0,
  received int DEFAULT 0,
  distributed int DEFAULT 0,
  closing_balance int GENERATED ALWAYS AS (opening_balance + received - distributed) STORED,
  month date NOT NULL,
  UNIQUE(rep_id, product_id, month)
)

-- SAMPLE DISTRIBUTIONS
sample_distributions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  rep_id uuid references profiles(id),
  visit_id uuid references dcr_doctor_visits(id),
  doctor_id uuid references doctors(id),
  product_id uuid references products(id),
  quantity int NOT NULL,
  distributed_at timestamptz DEFAULT now()
)

-- EXPENSES
expenses (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  rep_id uuid references profiles(id),
  category text CHECK (category IN ('fuel','vehicle','meals','doctor_gift','accommodation','other')),
  amount numeric NOT NULL,
  date date NOT NULL,
  description text,
  receipt_urls text[], -- Supabase Storage URLs
  status text CHECK (status IN ('pending','approved','rejected')),
  manager_note text,
  submitted_at timestamptz,
  approved_at timestamptz,
  created_at timestamptz DEFAULT now()
)

-- PAYMENTS (from chemists)
payments (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  rep_id uuid references profiles(id),
  chemist_id uuid references chemists(id),
  amount numeric NOT NULL,
  payment_date date NOT NULL,
  payment_mode text CHECK (payment_mode IN ('cash','bank_transfer','cheque')),
  receipt_number text UNIQUE DEFAULT 'RCP-' || substr(gen_random_uuid()::text, 1, 8),
  notes text,
  created_at timestamptz DEFAULT now()
)

-- COMPETITOR ACTIVITY
competitor_activities (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  rep_id uuid references profiles(id),
  dcr_visit_id uuid references dcr_doctor_visits(id),
  competitor_name text NOT NULL,
  product_name text,
  activity_type text CHECK (activity_type IN ('price_cut','new_launch','promotion','extra_sampling','other')),
  area text,
  date date NOT NULL,
  notes text,
  created_at timestamptz DEFAULT now()
)

-- AI CHAT HISTORY
ai_chat_messages (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid references profiles(id),
  role text CHECK (role IN ('user','assistant')),
  content text NOT NULL,
  action_taken jsonb, -- stores what the bot actually did
  created_at timestamptz DEFAULT now()
)
```

---

## FOLDER STRUCTURE

```
lib/
├── main.dart
├── app.dart                          # GoRouter + ProviderScope setup
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── supabase_constants.dart
│   ├── extensions/
│   ├── utils/
│   │   ├── date_utils.dart
│   │   ├── currency_utils.dart
│   │   └── validators.dart
│   └── errors/
│       └── app_exception.dart
├── data/
│   ├── local/                        # Drift database
│   │   ├── app_database.dart
│   │   ├── tables/
│   │   └── daos/
│   ├── remote/                       # Supabase clients
│   │   ├── supabase_client.dart
│   │   └── api_services/
│   └── models/                       # Freezed data models
│       ├── doctor.dart
│       ├── chemist.dart
│       ├── order.dart
│       ├── dcr.dart
│       └── ... (one per entity)
├── domain/
│   └── repositories/                 # Abstract interfaces
├── features/
│   ├── auth/
│   │   ├── providers/
│   │   ├── screens/
│   │   └── widgets/
│   ├── dashboard/
│   ├── doctors/
│   ├── chemists/
│   ├── products/
│   ├── tour_plan/
│   ├── dcr/
│   ├── wssr/
│   ├── orders/
│   ├── targets/
│   ├── samples/
│   ├── expenses/
│   ├── payments/
│   ├── competitors/
│   ├── ai_bot/
│   ├── reports/
│   └── notifications/
└── shared/
    ├── widgets/
    │   ├── achievement_meter.dart
    │   ├── sync_status_banner.dart
    │   ├── role_guard.dart
    │   └── ...
    └── providers/
        ├── auth_provider.dart
        └── connectivity_provider.dart
```

---

## MODULE-BY-MODULE IMPLEMENTATION INSTRUCTIONS

---

### MOD-01 — Authentication & Role Management

**Clerk Setup:**
- Use `clerk_flutter` package
- OTP via phone number (primary) and email
- After first successful Clerk login, upsert user into Supabase `profiles` table using a Supabase Edge Function triggered by Clerk webhook (`user.created`)
- Store role in `clerk_user_id.publicMetadata.role`
- Generate a Supabase custom JWT from Clerk JWT for RLS using Edge Function

**Riverpod Providers:**
```dart
// auth_provider.dart
@riverpod
Stream<ClerkUser?> clerkUser(ClerkUserRef ref) => Clerk.shared.userStream;

@riverpod
Future<Profile?> currentProfile(CurrentProfileRef ref) async {
  final user = ref.watch(clerkUserProvider).value;
  if (user == null) return null;
  return ref.read(profileRepositoryProvider).getProfileByClerkId(user.id);
}
```

**Rules:**
- After 3 failed OTP attempts → lock account 15 minutes
- Session expires after 30 days inactivity
- Biometric login available after first login (use `local_auth` package)
- Territory-based RLS: rep can only SELECT/INSERT rows where `territory_id = auth.jwt() ->> 'territory_id'`

---

### MOD-02 — Dashboard & Home Screen

**Rep Dashboard widgets (build each as separate widget):**
1. `TodayVisitChecklist` — pulls from `tour_plan_entries` for today, shows morning/evening slots
2. `AchievementMeter` — circular progress, color coded (red/orange/green), formula: `(month_sales / month_target) * 100`
3. `WeekOnWeekChart` — bar chart using `fl_chart` package
4. `GOLMIndicator` — per product growth chip list
5. `PendingItemsBadge` — count of unsubmitted DCRs, pending expenses, unapproved orders
6. `QuickActionFAB` — floating action button with speed dial: New DCR, Add Order, Open Bot

**Manager Dashboard extras:**
- `RepLeaderboard` — sorted by achievement %, shows name, territory, %, amount. Tap → rep detail view

**Riverpod:**
```dart
@riverpod
Future<DashboardData> dashboardData(DashboardDataRef ref) async {
  final profile = await ref.watch(currentProfileProvider.future);
  // fetch all widgets data in parallel using Future.wait
}
```

---

### MOD-03 — Doctor (HCP) Master Database

**Key behaviors:**
- Search debounced 300ms, minimum 2 chars, searches `name`, `clinic_name`, `area`
- Duplicate detection: warn if same name + area exists (Levenshtein distance check or Supabase full-text search)
- Doctor tier (A/B/C) only editable by manager/admin
- Bulk import: parse Excel using `excel` package, validate, batch insert
- Offline: full doctor list cached in Drift local DB, synced on app open

**Supabase RLS:**
```sql
-- Reps can only see doctors in their territory
CREATE POLICY "rep_territory_doctors" ON doctors
  FOR SELECT USING (territory_id = (SELECT territory_id FROM profiles WHERE id = auth.uid()));
```

---

### MOD-04 — Chemist / Pharmacy Master Database

**Same pattern as doctors plus:**
- `outstanding_balance` is a computed column updated via Supabase trigger after every new order or payment
- Inactive chemist alert: Supabase scheduled function (pg_cron) → query chemists with `last_visited_at < now() - interval '14 days'` AND priority = 'high' → insert into `notifications` table → FCM triggers

---

### MOD-05 — Product Catalog

**Key behaviors:**
- Only admin can update price. Use RLS + application-level check
- Price history maintained in `product_price_history` table
- Visual aids uploaded to Supabase Storage bucket `product-visuals`
- Cache PDFs locally using `flutter_cache_manager` for offline access
- Share product PDF via `share_plus` native share sheet

---

### MOD-06 — Tour Plan & Route Management

**UI:**
- Weekly calendar grid (Mon–Sat × Morning/Evening = 12 slots)
- Drag-and-drop doctors/chemists into slots using `flutter_draggable_gridview` or custom drag widget
- Submitted plans locked — show read-only view

**GPS Check-in:**
```dart
// On check-in button tap
final position = await Geolocator.getCurrentPosition();
final distance = Geolocator.distanceBetween(
  position.latitude, position.longitude,
  doctor.lat, doctor.lng,
);
if (distance > 500) {
  // Show soft warning — do not block
  showWarningSnackbar('You are ${distance.toStringAsFixed(0)}m from registered location');
}
// Save check-in regardless
```

**Deviation tracking:** If DCR visit `is_planned = false`, it counts as deviation. Manager can see planned vs actual in report.

---

### MOD-07 — Daily Call Report (DCR)

**Core flow:**
1. Rep opens DCR for today (auto-created as 'draft' on app open)
2. Morning/Evening sections show planned visits from Tour Plan
3. Tap visit → `DoctorVisitEntrySheet` (bottom sheet):
   - Pre-filled doctor details
   - Multi-select products detailed
   - Call outcome picker
   - Sample distribution (validates against inventory balance)
   - Optional photo
4. For chemist visits → `ChemistVisitEntrySheet` → inline order creation
5. Auto-save every change to Drift local DB
6. Submit button at day-end → pushes to Supabase → manager notified

**Voice memo:** Record using `flutter_sound`, upload to Supabase Storage, attach URL to DCR.

---

### MOD-08 — Weekly Sales Summary Report (WSSR)

**Data flow:**
- WSSR is NOT a separate input form — it is a **computed view** over orders data
- Build a Supabase database view or Edge Function that aggregates:

```sql
-- WSSR View
SELECT
  p.name as product_name,
  p.net_price,
  pr.full_name as rep_name,
  t.name as territory_name,
  SUM(CASE WHEN week_number(o.order_date) = 1 THEN oi.subtotal ELSE 0 END) as week1_sales,
  SUM(CASE WHEN week_number(o.order_date) = 2 THEN oi.subtotal ELSE 0 END) as week2_sales,
  -- ... weeks 3,4,5
  SUM(oi.subtotal) as month_sales,
  tg.monthly_target,
  ROUND((SUM(oi.subtotal) / NULLIF(tg.monthly_target, 0)) * 100, 2) as achievement_pct,
  SUM(oi.subtotal) - tg.monthly_target as diff
FROM order_items oi
JOIN orders o ON o.id = oi.order_id
JOIN products p ON p.id = oi.product_id
JOIN profiles pr ON pr.id = o.rep_id
JOIN territories t ON t.id = pr.territory_id
JOIN targets tg ON tg.rep_id = o.rep_id AND tg.product_id = oi.product_id AND tg.month = date_trunc('month', o.order_date)
GROUP BY p.id, pr.id, t.id, tg.monthly_target;
```

**GOLM formula:** `((current_month_sales - last_month_sales) / NULLIF(last_month_sales, 0)) * 100`

---

### MOD-09 — Order Management

**Order status machine:**
```
draft → submitted → confirmed → dispatched → delivered → paid
```

**After order submitted:**
- Trigger Supabase function to update `chemists.outstanding_balance += order.total_amount`
- Update WSSR view automatically (reactive)

**Invoice PDF generation:**
```dart
// Using 'pdf' package
Future<Uint8List> generateInvoicePdf(Order order) async {
  final pdf = pw.Document();
  pdf.addPage(pw.Page(build: (ctx) => pw.Column(children: [
    pw.Text('ORDER INVOICE', style: pw.TextStyle(fontSize: 20)),
    pw.Text('Order ID: ${order.invoiceNumber}'),
    // ... product table, totals, chemist details
  ])));
  return pdf.save();
}
```

---

### MOD-10 — Target & Achievement Tracking

**Target setting (manager only):**
- Form per rep per product per month
- Bulk upload: parse Excel → validate → batch upsert into `targets` table

**Per-product progress widget:**
```dart
// Circular progress indicator per product
// target, achieved, remaining amount
// Color: red if < 50%, orange 50-80%, green > 80%
// "X weeks left" countdown
```

---

### MOD-11 — Sample Management

**Validation (critical):**
```dart
// Before saving distribution
if (distribution.quantity > currentBalance) {
  throw AppException('Insufficient sample balance. Available: $currentBalance');
}
```

Update `sample_inventory.distributed` via Supabase trigger after each `sample_distributions` insert.

---

### MOD-12 — Expense Management

**Photo upload:**
- Compress image to max 1MB before upload using `flutter_image_compress`
- Upload to Supabase Storage bucket `expense-receipts`
- Store array of URLs in `expenses.receipt_urls`

**Without receipt:** status = 'pending' but flagged as 'Unverified' in UI badge.

---

### MOD-13 — Payment & Outstanding Tracking

**On payment logged:**
- Insert into `payments` table
- Supabase trigger: `UPDATE chemists SET outstanding_balance = outstanding_balance - payment.amount WHERE id = payment.chemist_id`
- Auto-generate receipt number

**Aging report query:**
```sql
SELECT chemist_id, shop_name,
  SUM(CASE WHEN age_days <= 30 THEN outstanding ELSE 0 END) as bucket_0_30,
  SUM(CASE WHEN age_days BETWEEN 31 AND 60 THEN outstanding ELSE 0 END) as bucket_31_60,
  SUM(CASE WHEN age_days BETWEEN 61 AND 90 THEN outstanding ELSE 0 END) as bucket_61_90,
  SUM(CASE WHEN age_days > 90 THEN outstanding ELSE 0 END) as bucket_90_plus
FROM orders_aging_view GROUP BY chemist_id, shop_name;
```

---

### MOD-15 — AI Assistant (Bot)

This is the **flagship feature**. Build a persistent chat UI with a floating button on every screen.

**Architecture:**
- Chat UI: `AiBotSheet` — slides up from bottom, persistent across navigation
- All API calls go through a **Supabase Edge Function** (to keep API key server-side)
- Edge Function: `ai-assistant` → receives `{ userId, message, conversationHistory, currentScreen }`

**Edge Function (Deno/TypeScript):**
```typescript
import Anthropic from "npm:@anthropic-ai/sdk";

const client = new Anthropic();

Deno.serve(async (req) => {
  const { userId, message, conversationHistory, userContext } = await req.json();

  // Build system prompt with user's live data context
  const systemPrompt = `
You are MedRep Pro's AI assistant for a pharmaceutical sales rep.
Current user: ${userContext.name}, Territory: ${userContext.territory}
Today's date: ${new Date().toISOString().split('T')[0]}
Role: ${userContext.role}

You can perform these ACTIONS by responding with structured JSON inside <action> tags:
- ADD_ORDER: { chemist_name, products: [{name, quantity}] }
- LOG_DOCTOR_VISIT: { doctor_name, products_detailed: [], samples_given: [], outcome }
- ADD_TOUR_PLAN_ENTRY: { day, session, entity_type, entity_name }
- GET_ACHIEVEMENT: { period: 'week'|'month' }
- GENERATE_REPORT: { type: 'DCR'|'WSSR'|'ORDER_SUMMARY', date_range }
- UPDATE_WSSR: { rep_name, product_name, week, value }

Always respond conversationally AND include an <action> tag if an action should be taken.
Always show a CONFIRMATION CARD before executing write actions.
For ambiguous names, ask a clarifying question.
Response time target: under 3 seconds.
  `;

  const response = await client.messages.create({
    model: "claude-sonnet-4-20250514",
    max_tokens: 1000,
    system: systemPrompt,
    messages: conversationHistory,
  });

  return new Response(JSON.stringify(response), {
    headers: { "Content-Type": "application/json" },
  });
});
```

**Flutter Bot UI:**
```dart
// AiBotProvider
@riverpod
class AiBotNotifier extends _$AiBotNotifier {
  @override
  List<ChatMessage> build() => [];

  Future<void> sendMessage(String text) async {
    state = [...state, ChatMessage(role: 'user', content: text)];
    
    final response = await ref.read(supabaseFunctionsProvider)
      .invoke('ai-assistant', body: {
        'userId': currentUserId,
        'message': text,
        'conversationHistory': state.map((m) => m.toJson()).toList(),
        'userContext': await ref.read(userContextProvider.future),
      });
    
    final parsed = AiBotResponse.fromJson(response.data);
    
    if (parsed.hasAction) {
      // Show confirmation card before executing
      await _showConfirmationCard(parsed.action);
    }
    
    state = [...state, ChatMessage(role: 'assistant', content: parsed.text)];
  }
}
```

**Voice Input:**
```dart
final speechToText = SpeechToText();
await speechToText.listen(onResult: (result) {
  if (result.finalResult) {
    // Show transcript to user for confirmation
    showTranscriptConfirmDialog(result.recognizedWords);
  }
});
```

---

### MOD-16 — Reports & Export Module

**Available reports (build each as a dedicated generator class):**

| Report | Data Source | Formats |
|--------|------------|---------|
| DCR | dcr + dcr_doctor_visits + dcr_chemist_visits | PDF, Excel |
| WSSR | wssr_view | Excel (exact template match) |
| Target vs Achievement | targets + orders | Excel, PDF |
| Order Summary | orders + order_items | Excel, PDF |
| Sample Distribution | sample_distributions | Excel, PDF |
| Expense Summary | expenses | Excel, PDF |
| Outstanding/Aging | aging view | Excel, PDF |
| Tour Plan vs Actual | tour_plans + dcr visits | PDF |
| Competitor Activity | competitor_activities | PDF |

**Excel export (WSSR must match head office template exactly):**
```dart
Future<List<int>> generateWSSRExcel(WSSRData data) async {
  var excel = Excel.createExcel();
  var sheet = excel['WSSR_${data.month}'];
  
  // Header rows matching current template
  sheet.cell(CellIndex.indexByString('A1')).value = data.companyName;
  sheet.cell(CellIndex.indexByString('A2')).value = 'Territory: ${data.territory}';
  // ... exact column structure from PRD
  
  return excel.encode()!;
}
```

---

### MOD-17 — Notifications & Alerts

**FCM Setup + Supabase pg_cron jobs:**

```sql
-- DCR reminder at 7 PM for reps who haven't submitted
SELECT cron.schedule('dcr-reminder', '0 19 * * *', $$
  INSERT INTO notification_queue (user_id, type, title, body)
  SELECT rep_id, 'DCR_REMINDER', 'Reminder', 'You have not submitted today''s DCR yet'
  FROM profiles
  WHERE role = 'medical_rep'
  AND id NOT IN (
    SELECT rep_id FROM dcrs WHERE date = CURRENT_DATE AND status = 'submitted'
  );
$$);
```

Process `notification_queue` via Supabase Edge Function → send via FCM.

---

### MOD-18 — Offline Mode & Data Sync

**Drift (SQLite) mirrors all reference tables locally:**
- `doctors`, `chemists`, `products`, `tour_plan_entries` (today + next 7 days)
- `dcrs` (last 7 days drafts)
- `orders` (pending sync queue)

**Sync logic:**
```dart
// ConnectivityProvider watches internet
// When back online → process offline queue in order
@riverpod
class SyncNotifier extends _$SyncNotifier {
  Future<void> syncPendingData() async {
    final pending = await ref.read(localDbProvider).getPendingSyncItems();
    for (final item in pending) {
      try {
        await ref.read(supabaseProvider).upsert(item.table, item.data);
        await ref.read(localDbProvider).markSynced(item.id);
      } catch (e) {
        // Exponential backoff retry
      }
    }
  }
}
```

**Sync status banner:** always visible at top of screen:
- 🟢 `Synced` — all good
- 🟡 `Syncing...` — in progress
- 🔴 `X items pending` — offline queue

**Conflict resolution:** If same record modified on two devices offline → Supabase `updated_at` timestamp wins (last-write-wins). Flag to user if significant discrepancy.

---

## RIVERPOD PATTERNS — FOLLOW STRICTLY

```dart
// Always use code generation
@riverpod
Future<List<Doctor>> doctors(DoctorsRef ref) async {
  // Watch connectivity — return from local DB if offline
  final isOnline = ref.watch(connectivityProvider);
  if (!isOnline) return ref.read(localDoctorsProvider);
  
  return ref.read(doctorRepositoryProvider).getAll();
}

// For mutations — use AsyncNotifier
@riverpod
class OrderCreator extends _$OrderCreator {
  @override
  AsyncValue<void> build() => const AsyncData(null);
  
  Future<void> createOrder(CreateOrderRequest request) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      // Save locally first (offline-safe)
      await ref.read(localDbProvider).saveOrder(request);
      // Try remote
      await ref.read(orderRepositoryProvider).create(request);
    });
  }
}
```

---

## UI / UX GUIDELINES

**Color System:**
```dart
// Primary: Deep Blue-Green (pharma/medical feel)
const kPrimary = Color(0xFF0D5C8C);
const kAccent = Color(0xFF00C2A8);
const kDanger = Color(0xFFE53935);
const kWarning = Color(0xFFFF8F00);
const kSuccess = Color(0xFF2E7D32);
const kBackground = Color(0xFFF4F6F9);
```

**Design Rules:**
- All primary actions reachable within 2 taps from any screen
- Bottom navigation: Dashboard, DCR, Orders, Reports, Bot
- Floating AI bot button on every screen (bottom-right)
- Loading states: skeleton shimmer (not spinners) for list screens
- Empty states: illustrated, actionable (not just "No data found")
- Every form auto-saves to local draft — never lose data
- Progress indicators for all file exports

---

## SUPABASE RLS POLICIES SUMMARY

```sql
-- Reps see only their territory data
-- Managers see all reps under them
-- Admin sees everything

-- Example pattern for all tables:
CREATE POLICY "access_by_role" ON [table]
FOR ALL USING (
  -- Admin: full access
  (SELECT role FROM profiles WHERE id = auth.uid()) = 'admin'
  OR
  -- Manager: see their reps' data
  (SELECT role FROM profiles WHERE id = auth.uid()) = 'manager'
  AND rep_id IN (SELECT id FROM profiles WHERE manager_id = auth.uid())
  OR
  -- Rep: own data only
  rep_id = auth.uid()
);
```

---

## IMPLEMENTATION ORDER (Build in this sequence)

1. ✅ Supabase project setup — all tables + RLS policies + seed data
2. ✅ Clerk integration — auth flow, role setup, webhook → Supabase profile sync
3. ✅ Core app structure — go_router, Riverpod scope, theme, offline/online detection
4. ✅ Drift local database setup — mirror tables, sync queue
5. ✅ MOD-01 Auth screens (login, OTP, biometric)
6. ✅ MOD-03 & MOD-04 Doctor/Chemist CRUD (foundation for everything else)
7. ✅ MOD-05 Product Catalog
8. ✅ MOD-06 Tour Plan
9. ✅ MOD-07 DCR (core daily workflow)
10. ✅ MOD-09 Orders
11. ✅ MOD-08 WSSR (computed from orders)
12. ✅ MOD-10 Targets
13. ✅ MOD-11 Samples
14. ✅ MOD-12 Expenses
15. ✅ MOD-13 Payments
16. ✅ MOD-02 Dashboard (aggregates all above data)
17. ✅ MOD-15 AI Bot (Supabase Edge Function + Flutter UI)
18. ✅ MOD-16 Reports & Export
19. ✅ MOD-17 Notifications (FCM + pg_cron)
20. ✅ MOD-18 Offline sync polish
21. ✅ MOD-14 Competitor logging
22. ✅ End-to-end testing + performance tuning

---

## CRITICAL BUSINESS RULES

1. **WSSR auto-calculates** — never let manager manually enter weekly numbers; all data flows from submitted orders
2. **Sample balance validation** — hard block if distribution > current balance
3. **Territory isolation** — a rep MUST NOT see another rep's doctors, orders, or customers
4. **DCR auto-draft** — create empty DCR draft at 6 AM daily via pg_cron
5. **Order price lock** — once order submitted, price changes do not retroactively affect it
6. **GOLM edge case** — if last month sales = 0, show 'N/A' not divide-by-zero crash
7. **Offline AI bot** — if offline, show "AI Assistant requires internet connection" — do not crash
8. **Manager cannot edit submitted DCR** — can only comment or acknowledge
9. **Tour plan lock** — once submitted, rep cannot edit unless manager returns it

---

## pubspec.yaml DEPENDENCIES

```yaml
dependencies:
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5
  supabase_flutter: ^2.5.4
  clerk_flutter: ^1.2.0
  drift: ^2.19.0
  go_router: ^14.0.0
  freezed_annotation: ^2.4.1
  json_annotation: ^4.9.0
  google_maps_flutter: ^2.6.1
  geolocator: ^12.0.0
  speech_to_text: ^6.6.2
  flutter_sound: ^9.2.13
  pdf: ^3.11.0
  excel: ^4.0.2
  share_plus: ^9.0.0
  flutter_image_compress: ^2.3.0
  cached_network_image: ^3.3.1
  flutter_cache_manager: ^3.4.1
  firebase_core: ^3.3.0
  firebase_messaging: ^15.1.0
  local_auth: ^2.3.0
  fl_chart: ^0.68.0
  shimmer: ^3.0.0
  connectivity_plus: ^6.0.3
  image_picker: ^1.1.2

dev_dependencies:
  riverpod_generator: ^2.4.3
  build_runner: ^2.4.11
  freezed: ^2.5.2
  json_serializable: ^6.8.0
  drift_dev: ^2.19.0
```

---

*Document generated from MedRep Pro PRD v1.0 | For use with AI-assisted development*
*Stack: Flutter + Riverpod + Supabase + Clerk*
