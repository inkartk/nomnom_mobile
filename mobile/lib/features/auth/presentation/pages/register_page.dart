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
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController(text: 'Alex');
  final _emailController = TextEditingController(text: 'alex@nomnom.app');
  final _passwordController = TextEditingController(text: 'password');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    context.read<AuthBloc>().add(
          RegisterRequested(
            name: _nameController.text.trim(),
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
        appBar: AppBar(title: Text(l10n.register)),
        body: AppGradientBackground(
          child: SafeArea(
            child: SingleChildScrollView(
              padding: AppSpacing.pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.register,
                    style: theme.textTheme.headlineMedium,
                  ),
                  AppSpacing.vXs,
                  Text(
                    'Create your account',
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
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: l10n.name,
                            prefixIcon: const Icon(Icons.person_outline),
                          ),
                        ),
                        AppSpacing.vMd,
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
                                  loading ? l10n.loading : l10n.register,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
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
