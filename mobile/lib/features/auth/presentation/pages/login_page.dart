import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomnom_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nomnom_mobile/theme/router/app_router.dart';
import 'package:nomnom_mobile/theme/app_colors.dart';
import 'package:nomnom_mobile/theme/app_spacing.dart';
import 'package:nomnom_mobile/utils/l10n.dart';
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
  final _emailController = TextEditingController(text: 'alex@nomnom.app');
  final _passwordController = TextEditingController(text: 'password');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    context.read<AuthBloc>().add(
          LoginRequested(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          context.router.replace(const HomeRoute());
        }
      },
      child: Scaffold(
        body: AppGradientBackground(
          child: SafeArea(
            child: SingleChildScrollView(
              padding: AppSpacing.pagePadding,
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
                    'Sign in to continue',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  AppSpacing.vXl,
                  GlassCard(
                    padding: AppSpacing.cardPaddingLarge,
                    child: Column(
                      children: [
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: l10n.email,
                            prefixIcon: const Icon(Icons.mail_outline),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        AppSpacing.vMd,
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: l10n.password,
                            prefixIcon: const Icon(Icons.lock_outline),
                          ),
                          obscureText: true,
                        ),
                        AppSpacing.vLg,
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            final loading =
                                state.formStatus == FormStatus.submitting;
                            return SizedBox(
                              width: double.infinity,
                              child: GradientButton(
                                onPressed: loading ? null : _submit,
                                child: Text(
                                  loading ? l10n.loading : l10n.login,
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
                      onPressed: () =>
                          context.router.push(const RegisterRoute()),
                      child: Text(l10n.register),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
