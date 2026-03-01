import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomnom_mobile/core/logging/app_talker.dart';
import 'package:nomnom_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nomnom_mobile/utils/l10n.dart';
import 'package:nomnom_mobile/widgets/app_background.dart';
import 'package:talker_flutter/talker_flutter.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profile),
        actions: [
          IconButton(
            icon: const Icon(Icons.bug_report_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => TalkerScreen(talker: appTalker),
                ),
              );
            },
          ),
        ],
      ),
      body: AppGradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final user = state.user;
              final initials = (user?.name ?? 'A').trim().isEmpty
                  ? 'A'
                  : (user?.name ?? 'A').trim().characters.first.toUpperCase();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                          child: Text(
                            initials,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user?.name ?? 'Alex',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                user?.email ?? 'alex@nomnom.app',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).hintColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => context.read<AuthBloc>().add(const LogoutRequested()),
                      icon: const Icon(Icons.logout),
                      label: Text(l10n.logout),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
