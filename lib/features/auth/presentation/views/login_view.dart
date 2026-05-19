import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medrep_pro/features/auth/presentation/providers/auth_state.dart';
import 'package:medrep_pro/features/auth/presentation/providers/auth_state_notifier.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _identifierController = TextEditingController();
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPhoneMode = false;

  @override
  void dispose() {
    _identifierController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _submitIdentifier() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(authStateProvider.notifier).sendOtp(
            _identifierController.text.trim(),
            isPhone: _isPhoneMode,
          );
    }
  }

  void _submitOtp() {
    if (_otpController.text.trim().length == 6) {
      ref
          .read(authStateProvider.notifier)
          .verifyOtp(_otpController.text.trim());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 6-digit OTP code')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authStateProvider);
    final theme = Theme.of(context);

    // If OTP is sent, we fill the controller identifier just in case of redraw
    if (state is AuthOtpSent) {
      _identifierController.text = state.emailOrPhone;
      _isPhoneMode = state.isPhone;
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.primaryContainer.withOpacity(0.3),
              theme.colorScheme.surface,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // App Brand Logo/Header
                  Icon(
                    Icons.medical_services_outlined,
                    size: 80,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'MedRep Pro',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    'Enterprise Pharma Sales Platform',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Main Interactive Authentication Panel
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (state is AuthOtpSent) ...[
                            // OTP VERIFICATION VIEW
                            Text(
                              'Verify Code',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Enter the 6-digit code sent to ${_isPhoneMode ? "phone" : "email"}:\n${state.emailOrPhone}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: _otpController,
                              keyboardType: TextInputType.number,
                              maxLength: 6,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                letterSpacing: 8,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                hintText: '000000',
                                counterText: '',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onChanged: (val) {
                                if (val.length == 6) {
                                  _submitOtp();
                                }
                              },
                            ),
                            const SizedBox(height: 24),
                            if (state is AuthLoading)
                              const Center(child: CircularProgressIndicator())
                            else ...[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: _submitOtp,
                                child: const Text('Verify OTP'),
                              ),
                              const SizedBox(height: 12),
                              TextButton(
                                onPressed: () {
                                  ref.read(authStateProvider.notifier).sendOtp(
                                        state.emailOrPhone,
                                        isPhone: state.isPhone,
                                      );
                                },
                                child: const Text('Resend Code'),
                              ),
                            ],
                          ] else ...[
                            // IDENTIFIER ENTRY VIEW
                            SegmentedButton<bool>(
                              segments: const [
                                ButtonSegment(
                                  value: false,
                                  label: Text('Email'),
                                  icon: Icon(Icons.email_outlined),
                                ),
                                ButtonSegment(
                                  value: true,
                                  label: Text('Phone'),
                                  icon: Icon(Icons.phone_outlined),
                                ),
                              ],
                              selected: {_isPhoneMode},
                              onSelectionChanged: (newSelection) {
                                setState(() {
                                  _isPhoneMode = newSelection.first;
                                  _identifierController.clear();
                                });
                              },
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: _identifierController,
                              keyboardType: _isPhoneMode
                                  ? TextInputType.phone
                                  : TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: _isPhoneMode
                                    ? 'Phone Number'
                                    : 'Email Address',
                                prefixIcon: Icon(
                                    _isPhoneMode ? Icons.phone : Icons.email),
                                hintText: _isPhoneMode
                                    ? '+1234567890'
                                    : 'name@company.com',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return 'Field is required';
                                }
                                if (!_isPhoneMode && !val.contains('@')) {
                                  return 'Enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),
                            if (state is AuthLoading)
                              const Center(child: CircularProgressIndicator())
                            else ...[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: _submitIdentifier,
                                child: const Text('Send Verification Code'),
                              ),
                              const SizedBox(height: 16),
                              // Biometric Shortcut Option
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  ref
                                      .read(authStateProvider.notifier)
                                      .authenticateWithBiometrics();
                                },
                                icon: const Icon(Icons.fingerprint),
                                label: const Text('Sign in with Biometrics'),
                              ),
                            ],
                          ],
                        ],
                      ),
                    ),
                  ),

                  // Display Error Messages
                  if (state is AuthError) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: theme.colorScheme.onErrorContainer,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
