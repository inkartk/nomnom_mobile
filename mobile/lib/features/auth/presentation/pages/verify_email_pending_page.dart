import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomnom_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nomnom_mobile/theme/router/app_router.dart';
import 'package:nomnom_mobile/theme/app_colors.dart';
import 'package:nomnom_mobile/theme/app_spacing.dart';
import 'package:nomnom_mobile/widgets/app_background.dart';
import 'package:nomnom_mobile/widgets/glass_card.dart';
import 'package:nomnom_mobile/widgets/gradient_button.dart';

@RoutePage()
class VerifyEmailPendingPage extends StatelessWidget {
  final String email;

  const VerifyEmailPendingPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (prev, curr) => prev.formStatus != curr.formStatus,
      listener: (context, state) {
        if (state.formStatus == FormStatus.resendSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email resent. Please check your inbox.'),
            ),
          );
        } else if (state.formStatus == FormStatus.failure &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      builder: (context, state) {
        final loading = state.formStatus == FormStatus.submitting;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.read<AuthBloc>().add(const AuthFormReset());
                context.router.replace(const LoginRoute());
              },
            ),
            title: const Text('Verify your email'),
          ),
          body: AppGradientBackground(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: AppSpacing.pagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppSpacing.vXl,
                    Icon(
                      Icons.mark_email_unread_outlined,
                      size: 96,
                      color: theme.colorScheme.primary,
                    ),
                    AppSpacing.vLg,
                    Text(
                      'Check your email',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineMedium,
                    ),
                    AppSpacing.vSm,
                    Text(
                      'We sent a confirmation link to:',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    AppSpacing.vXs,
                    Text(
                      email,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium,
                    ),
                    AppSpacing.vXl,
                    GlassCard(
                      padding: AppSpacing.cardPaddingLarge,
                      child: Column(
                        children: [
                          Text(
                            'Open the link in the email to activate your account. Didn\'t get the email?',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium,
                          ),
                          AppSpacing.vLg,
                          SizedBox(
                            width: double.infinity,
                            child: GradientButton(
                              onPressed: loading
                                  ? null
                                  : () => context.read<AuthBloc>().add(
                                        ResendVerificationRequested(
                                            email: email),
                                      ),
                              child: Text(
                                loading ? 'Sending...' : 'Resend email',
                              ),
                            ),
                          ),
                          AppSpacing.vSm,
                          TextButton(
                            onPressed: () {
                              context
                                  .read<AuthBloc>()
                                  .add(const AuthFormReset());
                              context.router.replace(const LoginRoute());
                            },
                            child: const Text('Back to sign in'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
