import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clerk_auth/clerk_auth.dart';

/// Provider for Clerk's core Auth SDK instance.
/// This provider is overridden in main.dart after the instance is pre-initialized.
final clerkAuthProvider = Provider<Auth>((ref) {
  throw UnimplementedError('clerkAuthProvider has not been initialized');
});
