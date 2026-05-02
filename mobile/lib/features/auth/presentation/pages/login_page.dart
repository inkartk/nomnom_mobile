import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomnom_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nomnom_mobile/theme/router/app_router.dart';
import 'package:nomnom_mobile/theme/app_colors.dart';
import 'package:nomnom_mobile/theme/app_spacing.dart';
import 'package:nomnom_mobile/utils/l10n.dart';
import 'package:nomnom_mobile/utils/validators.dart';
import 'package:nomnom_mobile/widgets/app_background.dart';
import 'package:nomnom_mobile/widgets/glass_card.dart';
import 'package:nomnom_mobile/widgets/gradient_button.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_autovalidateMode != AutovalidateMode.onUserInteraction) {
      setState(() => _autovalidateMode = AutovalidateMode.onUserInteraction);
    }
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<AuthBloc>().add(
          LoginRequested(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, curr) =>
          prev.status != curr.status || prev.formStatus != curr.formStatus,
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          context.router.replace(const HomeRoute());
        } else if (state.status == AuthStatus.emailUnverified &&
            state.pendingEmail != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? l10n.emailNotVerified),
              action: SnackBarAction(
                label: l10n.resend,
                onPressed: () {
                  context.read<AuthBloc>().add(
                        ResendVerificationRequested(
                          email: state.pendingEmail!,
                        ),
                      );
                  context.router.push(
                    VerifyEmailPendingRoute(email: state.pendingEmail!),
                  );
                },
              ),
              duration: const Duration(seconds: 6),
            ),
          );
        } else if (state.formStatus == FormStatus.failure &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AppGradientBackground(
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: AppSpacing.pagePadding,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Form(
                        key: _formKey,
                        autovalidateMode: _autovalidateMode,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 48),
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: AppColors.accentGradient,
                              ).createShader(bounds),
                              child: Text(
                                'NomNom',
                                style: theme.textTheme.headlineLarge?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            AppSpacing.vSm,
                            Text(
                              l10n.login,
                              style: theme.textTheme.headlineMedium,
                            ),
                            AppSpacing.vXs,
                            Text(
                              l10n.signInToContinue,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            AppSpacing.vXl,
                            GlassCard(
                              padding: AppSpacing.cardPaddingLarge,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      labelText: l10n.email,
                                      prefixIcon:
                                          const Icon(Icons.mail_outline),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    autofillHints: const [AutofillHints.email],
                                    textInputAction: TextInputAction.next,
                                    validator: (v) =>
                                        Validators.email(v, l10n),
                                  ),
                                  AppSpacing.vMd,
                                  TextFormField(
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                      labelText: l10n.password,
                                      prefixIcon:
                                          const Icon(Icons.lock_outline),
                                      suffixIcon: IconButton(
                                        icon: Icon(_obscurePassword
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined),
                                        onPressed: () => setState(() =>
                                            _obscurePassword =
                                                !_obscurePassword),
                                      ),
                                    ),
                                    obscureText: _obscurePassword,
                                    autofillHints: const [
                                      AutofillHints.password
                                    ],
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (_) => _submit(),
                                    validator: (v) =>
                                        Validators.password(v, l10n),
                                  ),
                                  AppSpacing.vLg,
                                  BlocBuilder<AuthBloc, AuthState>(
                                    builder: (context, state) {
                                      final loading = state.formStatus ==
                                          FormStatus.submitting;
                                      return SizedBox(
                                        width: double.infinity,
                                        child: GradientButton(
                                          onPressed: loading ? null : _submit,
                                          child: Text(
                                            loading
                                                ? l10n.loading
                                                : l10n.login,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            AppSpacing.vMd,
                            Center(
                              child: TextButton(
                                onPressed: () => context.router
                                    .push(const RegisterRoute()),
                                child: Text(l10n.register),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
